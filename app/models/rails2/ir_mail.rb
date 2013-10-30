class IrMail < ActionMailer::Base
  
  @@default_charset = "iso-2022-jp"
  @@encode_subject  = false
  
  def ir_message(m,sent_at = Time.now)
    recipients "h.tanaka@yamaokaya.co.jp" if(ENV["RAILS_ENV"] == "development")
    recipients "ir@yamaokaya.jp" if(ENV["RAILS_ENV"] == "production")
    
    from m.mail_addr ? base64(m.name+"様") + "<" + m.mail_addr + ">" : "info@yamaokaya.co.jp"
    sent_on    sent_at
    subject base64("IR問い合わせメール")
    body :message => Kconv.tojis(m.message)
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
