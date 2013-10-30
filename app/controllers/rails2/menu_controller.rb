
class MenuController < ApplicationController
  
  caches_action :menu
  layout "menu"
  def index
    params[:page] = 0 if not params[:page]
    @menus = Menu.find_current(params[:page])
    
      @menu = Menu.top_push.first

    if @menu != nil then
      render_menu
    else
      render :template => "menu/index"
    end
  end
  
  
  def menu
    @menus = Menu.find_current(params[:page])
    @menu = Menu.find(params[:id])
    render_menu
  end

  def send_message_resque

    arr = [4254,4255,4256,4257,4258,4259,4260,4261,4262,4263,4264,4265,4266,4267,4268,4269,4270,4271,4272,4273,4274,4275,4276,4277,4278,4279,4280,4281,4282,4283,4284,4285,4286,4287,4288,4289,4290,4291,4292,4293,4294,4295,4296,4297,4298];

    arr.each do |i|

      customer_message = CustomerMessage.find(i)

      CustomerMail.deliver_customer_message(customer_message)

      CustomerMail.deliver_customer_message_inspected(customer_message)

    end

  end

  private
  def render_menu
    if @menu.canpaign_page then
      render :action => @menu.canpaign_page
    else
      render :template => "menu/menu"
    end
  end
end
