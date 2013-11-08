class JobApplicant < ActiveRecord::Base
  include RecruitReportSendable
  belongs_to :shop
  attr :mail_addr_confirmation
  validates :name,presence: true
  validates :shop_id,presence: true
  validates :birthday,presence: true
  validates :zip,presence:true
  validates :address,presence:true
  validates :phone,presence:true
  validates :mail_addr,{
    presence: true,
    confirmation: true,
    format: {
      with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/}
  }
  validates :mail_addr_confirmation,presence:true

  scope :not_sent,-> { where(sent: false)}

  #動的メソッドの追加
  (0..31).each do |i|
    define_method("work_times_#{i}") do
      (self.work_times & (1 << i)).zero? ? 0 : 1
    end
    define_method("work_times_#{i}=") do |sv|
      v = sv.to_i
      v = 1 if v > 1
      v = 0 if v < 0
      self.work_times = 0 if self.work_times.nil?
      self.work_times = self.work_times | (v << i)
    end
    #attr "work_times_#{i}".to_sym
  end
end
