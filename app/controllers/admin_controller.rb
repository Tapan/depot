class AdminController < ApplicationController
  def index
    @order = Order.count
  end
end
