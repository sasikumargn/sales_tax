require 'uri'
require 'net/http'

class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :update]

  def new
    @cart = Cart.new
    5.times { @cart.items.build }
  end
  
  def create
    @cart = Cart.new(cart_params)
    @cart.currency_type = "EUR"
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
      else
        5.times { @cart.items.build } if @cart.items.blank?
        format.html { render :new }
      end
    end
  end

  def show
    fetch_fixer_latest
    respond_to do |format|
      format.html
      format.text do
        response.headers['Content-Type'] = 'text/plain'
        response.headers['Content-Disposition'] = "attachment; filename=receipt.txt"
      end
    end
  end

  def update
    @cart.update_attributes(currency_type: params[:currency_type])
    fetch_fixer_latest
  end

  def fetch_fixer_latest
    uri = URI("http://data.fixer.io/api/latest?access_key=#{Cart::FIXERACCESSKEY}&symbols=EUR,INR,USD")
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
    @currency_conversion_rate = response["rates"].present? && response["rates"][@cart.currency_type].present? ? response["rates"][@cart.currency_type] : 1
  end

  private

  def cart_params
    params.require(:cart).permit(:currency_type, items_attributes: [:quantity, :description, :price])
  end

  def set_cart
    @cart = Cart.find_by_id(params[:id])
  end

end
