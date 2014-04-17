SES = AWS::SES::Base.new(access_key_id: ENV["SES_KEY"],secret_access_key: ENV["SES_SECRET"])

#SES.send_email(to:'hisato.tanaka@gmail.com',source:'info@yamaokaya.com',subject:'test',body:'test')
