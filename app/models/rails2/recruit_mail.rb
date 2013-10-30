class RecruitMail < ActionMailer::Base
  
  @@default_charset = "iso-2022-jp"
  @@encode_subject  = false
  
  def recruit_message(m,sent_at = Time.now)
    recipients "h.tanaka@yamaokaya.co.jp" if(ENV["RAILS_ENV"] == "development")
    recipients "saiyo@yamaokaya.com,shop_#{m.shop.id}@yamaokaya.co.jp" if(ENV["RAILS_ENV"] == "production")
    
    from m.mail_addr ? base64(m.name+"様") + "<" + m.mail_addr + ">" : "info@yamaokaya.com"
    sent_on    sent_at
    subject base64("求人応募メール:" + (if m.shop.nil? then "未選択" else m.shop.name end))
    body(
      :message => Kconv.tojis(m.message),
      :name => Kconv.tojis(m.name),
      :age => Kconv.tojis(m.age.to_s),
      :zip => Kconv.tojis(m.zip),
      :address => Kconv.tojis(m.address),
      :phone => Kconv.tojis(m.phone),
      :mail_addr => Kconv.tojis(m.mail_addr),
      :shop => Kconv.tojis(if m.shop.nil? then "未選択" else m.shop.name end),
      :work_style => Kconv.tojis(m.work_style)
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
  
  
end
