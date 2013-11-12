class RecruitController < ApplicationController

  anot :index , parent: 'top#index',title:'人財募集'
  def index
  end

  anot :entry, parent: 'recruit#index',title: 'エントリー'
  def entry
    @job_applicant = JobApplicant.new
  end

  def entry_post
    @job_applicant = JobApplicant.new(job_applicant_params)
    if @job_applicant.save
      #TODO:メール送信はsidekiqに移行させるがとりあえず同期処理
      #まだ送られていない案件をすべて送信する
      JobApplicant.not_sent.each do |i|
        i.report do |params|
          render_to_string params
        end unless i.reported?
      end
      redirect_to url_for(action: :entry),notice: "ご応募まことにありがとうございます。後ほど担当者よりご連絡させていただきます。"
    else
      render action: :entry,notice: "エラーが発生いたしました。大変申し訳ありませんが、時間を置いて再度お試しください。"
    end
  end

  private
  def job_applicant_params
    params[:job_applicant][:ip_addr] = request.remote_ip()
    params.require(:job_applicant).permit(
      :male,
      :birthday,
      :zip,
      :address,
      :phone,
      :mail_addr,
      :mail_addr_confirmation,
      :work_style,
      :method,
      :ip_addr,
      :lat,
      :lng,
      :shop_id,
      :name,
      :message,
      :work_times_0,:work_times_1,:work_times_2,:work_times_3,:work_times_4,:work_times_5,:work_times_6,
      :work_times_7,:work_times_8,:work_times_9,:work_times_10,:work_times_11,:work_times_12,:work_times_13,
      :work_times_14,:work_times_15,:work_times_16,:work_times_17,:work_times_18,:work_times_19,:work_times_20,
      :work_times_21,:work_times_22,:work_times_23,:work_times_24,:work_times_25,:work_times_26,:work_times_27,
      :work_times_28,:work_times_29,:work_times_30,:work_times_31
    )
  end
end
