module ReportMailSendable
  extend ActiveSupport::Concern

  def reported?
    self.mail_sent
  end

  def report
    ses = AWS::SES::Base.new(
      :access_key_id => 'AKIAI2Q5IAVIWTLA2SKA',
      :secret_access_key => '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')

    ses.send_email(
      :to        => 'tanaka@yamaokaya.com',
      :source    => 'info@yamaokaya.com',
      :subject   => "IR問い合わせメール(#{self.id})",
      :text_body => self.message
    )
    self.mail_sent = true
    self.save
  end
end