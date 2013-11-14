class OrdersController < ApplicationController
  before_action :require_login, except: [:new, :show, :checkout]
  before_action :require_admin, only: [:index]

  def index
    @orders = Order.all
  end

  def new
    order = Order.create
    cookies[:order_id] = order.id
    redirect_to items_path
  end

  def show
    if cookies[:order_id]
      @order = Order.find(cookies[:order_id])
    elsif params[:id]
      @order = Order.find(params[:id])
    end
    @order_items = @order.order_items
  end

  def checkout
    unless current_user
      flash.notice = "Login is required to checkout"
      redirect_to login_path
    else
      current_user.associate_order(cookies[:order_id])
      @order = Order.where(user_id: current_user.id).last
      @items = @order.items
    end
  end

#  def place_order
#    current_user.change_order_to_completed
#    flash.notice = "Your order is successfull"
#    cookies.delete :order_id
#    UserMailer.order_email(current_user, current_user.orders.last).deliver
#    redirect_to user_path(current_user)
#  end
end
