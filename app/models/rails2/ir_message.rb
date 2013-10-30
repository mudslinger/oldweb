class IrMessage < ActiveRecord::Base
  validates_presence_of :name,:mail_addr,:address,:phone,:message
  validates_format_of :mail_addr,:with=> /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def body_raw
    return <<"EOS"
お名前: #{self.name}
会社名： #{self.company_name}
メールアドレス: #{self.mail_addr}
ご住所: #{self.address}
電話番号: #{self.phone}
メッセージ: -
#{self.message}
EOS
  end
end
