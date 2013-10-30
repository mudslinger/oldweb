class CouponsController < ApplicationController
	layout "blank"
	before_filter :do_nothing
	def use
		
		@coupon_code = params[:coupon_code]
		#クーポンコードのフォーマット
		#[任意のコード]_cpn_yyyyMMdd
		begin
			ymd_str = @coupon_code.split('_cpn_').last
			ymd = Date.strptime(ymd_str,'%Y%m%d')
		rescue 
			#十分な未来を指定
			ymd = Time.mktime 2099, 12, 31
		end
		@expired = 0.days.ago >= ymd + 1.days
	end
	private
	def do_nothing
	end
end
