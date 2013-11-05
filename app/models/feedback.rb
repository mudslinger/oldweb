class Feedback < ActiveRecord::Base
  validates :name,presence: true
  validates :mail_addr,{
    presence: true,
    confirmation: true,
    format: {
      with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/}
  }
  validates :mail_addr_confirmation,presence:true,confirmation:true
  attr :mail_addr_confirmation

end
