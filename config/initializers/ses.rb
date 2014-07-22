module OLDWEB
  AWS_CREDENTIALS =  JSON.parse(RestClient.get 'http://192.168.11.30:7700/ssconnect/trigger/aws/credentials.json', {:accept => :json})
  #AWS.config(AWS_CREDENTIALS)
  SES = AWS::SES::Base.new(
  	access_key_id: AWS_CREDENTIALS['access_key_id'],
  	secret_access_key: AWS_CREDENTIALS['secret_access_key']
  )
end

