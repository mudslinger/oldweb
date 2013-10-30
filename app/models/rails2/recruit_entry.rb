class RecruitEntry < ActiveRecord::Base
  
  validates_presence_of :name,:mail_addr,:age,:address,:phone,:shop_id
  validates_format_of :mail_addr,:with=> /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_numericality_of :age
  validates_inclusion_of :age,:in => 15..75
  validates_confirmation_of :mail_addr
  belongs_to :shop,:foreign_key => "shop_id"
  
  @maddr_user = ""
  @maddr_domain = ""
  attr_accessor :maddr_user,:maddr_domain,:work_style
  #work_style = "パート・アルバイト"

  def mail_addr_confirmation
    return @maddr_user + "@" + @maddr_domain
  end

  def body_raw
    return <<"EOS"
お名前: #{self.name}
年齢: #{self.age}
郵便番号： #{self.zip}
メールアドレス: #{self.mail_addr}
ご住所: #{self.address}
電話番号: #{self.phone}
勤務形態: #{self.work_style}
メッセージ: -
#{self.message}
EOS
  end

  SEX_OPTS = [
   ["男性", true],
   ["女性", false]
  ].freeze
  WS_OPTS = [["パート・アルバイト","パート・アルバイト"],["正社員・契約社員","正社員・契約社員"]].freeze
end
