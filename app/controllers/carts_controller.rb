class CartsController < ApplicationController
  include CurrentCart
  before_filter :authenticate_user!, only: [:checkout]
  before_action :set_cart, only: [:show, :edit, :update, :destroy, :checkout, :order_complete]

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    redirect_to root_path
  end

  def order_complete
    @order = Order.find(params[:order_id])
    @amount = (@order.grand_total.to_f.round(2)*100).to_i

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    @cart.destroy

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path  
  end

  def checkout
    @order = Order.new
    @order.user_id = current_user.id   
    
    @order.subtotal = @cart.subtotal
    @order.sales_tax = @cart.subtotal * 0.07
    @order.grand_total = @cart.subtotal + @order.sales_tax
    @order.save

    @cart.line_items.each do |line_item|
      line_item.product.quantity -= line_item.quantity
      line_item.product.save
    end
  
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user_id)
    end
end
