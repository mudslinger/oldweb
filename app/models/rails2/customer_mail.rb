require 'MeCab' if(ENV["RAILS_ENV"] == "production")
class CustomerMail < ActionMailer::Base
  
  @@default_charset = "iso-2022-jp"
  @@encode_subject  = false
  def customer_message(m,sent_at = Time.now)
    sub = "お客様よりメール(No.#{m.id})"
    sub += "[要返信]" if m.reply
    sub += "【"+m.shop.name+"】" if !m.shop.nil?
    subject base64(sub)
    recipients "tanaka@yamaokaya.com" if(ENV["RAILS_ENV"] == "development")
    recipients "info@yamaokaya.jp" if(ENV["RAILS_ENV"] == "production")
    from "info@yamaokaya.com"
    headers "X-Message-Flag" => base64("返信してください"),"Reply-By" => sent_at + 3600*24 if m.reply
    sent_on sent_at
    body(
      :message => Kconv.tojis(m.message),
      :name => Kconv.tojis(m.name),
      :mail_addr => m.mail_addr,
      :address => Kconv.tojis(m.address),
      :phone => Kconv.tojis(m.phone),
      :ip_addr => m.ip_addr,
      :region => m.region,
      :age => m.age_txt,
      :sex => m.sex_txt,
      :shop => Kconv.tojis(if m.shop.nil? then "未選択" else m.shop.name end),
      :visit_date => (m.visit_date.strftime("%Y/%m/%d")),
      :visit_time => m.visit_time_txt,
      :repetition => m.rept_txt,
      :q => m.qsca_txt(m.q),
      :s => m.qsca_txt(m.s),
      :c => m.qsca_txt(m.c),
      :a => m.qsca_txt(m.a),
      :menu => Kconv.tojis(if m.menu.nil? then "未選択" else m.menu.name end),
      :reply => m.reply ? "希望する" : "希望しない"
    )      
  end
  
  def testsend(to = 'tanaka@yamaokaya.com')
    recipients to
  end

  def customer_message_inspected(m,sent_at = Time.now)
    sub = "お客様よりメール(No.#{m.id})[個人情報削除済]"
    sub += "【"+m.shop.name+"】" if !m.shop.nil?
    subject base64(sub)
    recipients "tanaka@yamaokaya.com" if(ENV["RAILS_ENV"] == "development")
    recipients "customer_message@yamaokaya.co.jp" if(ENV["RAILS_ENV"] == "production")
    from "info@yamaokaya.com"
    sent_on sent_at
    body(
      :message => Kconv.tojis(privacy_check(m.message)),
      :region => m.region,
      :age => m.age_txt,
      :sex => m.sex_txt,
      :shop => Kconv.tojis(if m.shop.nil? then "未選択" else m.shop.name end),
      :visit_date => (m.visit_date.strftime("%Y/%m/%d")),
      :visit_time => m.visit_time_txt,
      :repetition => m.rept_txt,
      :q => m.qsca_txt(m.q),
      :s => m.qsca_txt(m.s),
      :c => m.qsca_txt(m.c),
      :a => m.qsca_txt(m.a),
      :menu => Kconv.tojis(if m.menu.nil? then "未選択" else m.menu.name end),
      :reply => m.reply ? "希望する" : "希望しない"
    )      
  end
  


  private
    def base64(text, charset="iso-2022-jp", convert=true)
      if convert
        if charset == "iso-2022-jp"
          text = Kconv.tojis(text)
        end
      end
      text = [text].pack('m').delete("\r\n")
      "=?#{charset}?B?#{text}?="
    end

    def privacy_check(message)
        begin
          source = ""
          message.each_line do |l|
            source += (/。$/=~ l.chomp ? l : l.chomp) if l.chomp.length != 0
          end
          parser = MeCab::Tagger.new()
          mnodes = parser.parseToNode(source)
          txt = ""
          while mnodes do
            if mnodes.feature.include?("人名") and mnodes.feature.include?("固有")
              txt += "●●"
            else
              txt += mnodes.surface
            end
            mnodes = mnodes.next
          end
          txt
        rescue
          message
        end
    end
end