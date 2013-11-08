class FeedbacksController < ApplicationController
  #before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  layout 'blank', :only => :search
  def search
    lat = params[:lat]
    lng = params[:lng]
    @return_id = params[:return_id]
    puts '--------------------------------'
    puts params
    @shops = Shop.nearest(lat,lng,4)
  end

  def index
    @feedback = Feedback.new
  end

  def send_message
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      #TODO:メール送信はsidekiqに移行させるがとりあえず同期処理
      #まだ送られていない案件をすべて送信する
      # IrMessage.not_sent.each do |i|
      #   i.report unless i.reported?
      # end
      redirect_to url_for(action: :index),notice: "メッセージありがとうございます。"
    else
      render action: :index
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params[:feedback][:ip_addr] = request.remote_ip()
      params[:feedback].permit(
        :name,
        :age,
        :male,
        :mail_addr,
        :mail_addr_confirmation,
        :address,
        :phone,
        :shop_id,
        :visit_date,
        :visit_time,
        :repetition,
        :menu_id,
        :q,:s,:c,:a,
        :message,
        :reply,
        :lat,
        :lng,
        :ip_addr
      )
    end
end
