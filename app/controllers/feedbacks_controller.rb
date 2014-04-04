class FeedbacksController < ApplicationController
  #before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  API_AUTH_KEY = 'ExThz6wX079RSstv258350G4rxLDy5Xo'
  force_ssl only: [:send_message,:index,:api]
  before_filter :force_plain,except: [:send_message,:index,:search]
  before_filter :set_headers,only: [:api]
  around_filter :auth_api,only: [:api]
  layout 'blank', :only => :search
  def search
    lat = params[:lat]
    lng = params[:lng]
    @return_id = params[:return_id]
    puts '--------------------------------'
    puts params
    @shops = Shop.nearest(lat,lng,4)
  end

  def api
    @feedback = set_feedback
    respond_to{ |format|
      format.json{render json: @feedback}
    }
  end

  def index
    @feedback = Feedback.new
  end

  def send_message
    #Feedback.transaction do
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      #OPTIMIZE:メール送信はsidekiqに移行させるがとりあえず同期処理
      #まだ送られていない案件をすべて送信する

      Feedback.not_sent.each do |i|
        i.report do |params|
          render_to_string params
        end unless i.reported?
      end
      redirect_to url_for(action: :index,format: :html),notice: "ご意見をいただき、まことにありがとうございます。今後も何かございましたら、是非ご意見をお寄せください。"
    else
      render action: :index,format: :html,notice: "エラーが発生いたしました。大変申し訳ありませんが、時間を置いて再度お試しください。"
    end
  end

  private

    def auth_api
      if params['key'] == API_AUTH_KEY
        yield
      else
        head :forbidden
        return false
      end
    end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Expose-Headers'] = "ETag"
      headers['Access-Control-Allow-Methods'] = "GET"
      headers['Access-Control-Allow-Headers'] = "HTTP_ORIGIN"
      headers['Access-Control-Max-Age'] = "86400"
      headers['Access-Control-Allow-Credentials'] = "true"
    end

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
