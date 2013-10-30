class RecruitController < ApplicationController
  ssl_required :entry,:entry_send
  def index
    @rec_info = Recruit.active
    @rec_info = Recruit.find(
      :all,
      :conditions => "current_timestamp between offer_from and offer_to",
      :joins => "inner join shops on (shops.id = shop_id)",
      :select => "*,shops.name as shop_name,shops.address as shop_address,shops.phone as shop_phone"
    )
  end

  def entry
    @recruit_entry = RecruitEntry.new(params[:recruit_entry])
    @recruit_entry.shop_id = params[:shop_id] if ! params[:shop_id].nil?
  end
  
  def entry_send
    @recruit_entry = RecruitEntry.new(params[:recruit_entry])
    if @recruit_entry.save
      #RecruitMail.deliver_recruit_message(@recruit_entry)
      ses_send(@recruit_entry)
      flash[:notice] = "ご応募ありがとうございました。担当者よりご連絡させていただきます。"
      redirect_to :action => "entry"
    else
      render :template => "recruit/entry"
    end
  end

  def ses_send(m)
    ses = AWS::SES::Base.new(
      :access_key_id => 'AKIAI2Q5IAVIWTLA2SKA',
      :secret_access_key => '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')
    
    selected_shop = '未選択'
    selected_shop = m.shop.name if m.shop.present?
    to = ['saiyo@yamaokaya.com','tanaka@yamaokaya.com','sales-man@yamaokaya.com']
    to << "s#{m.shop.short_id}@yamaokaya.com" if m.shop.present? && m.work_style == 'パート・アルバイト'
    to << "s#{m.shop.short_id}-sv@yamaokaya.com" if m.shop.present? && m.work_style == 'パート・アルバイト'
    ses.send_email(
      :to        => to,
      :source    => 'info@yamaokaya.com',
      :subject   => "求人応募メール(#{selected_shop})",
      :text_body => m.body_raw
    )
  end
end