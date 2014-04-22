SES = AWS::SES::Base.new(access_key_id: ENV["SES_KEY"],secret_access_key: ENV["SES_SECRET"])
