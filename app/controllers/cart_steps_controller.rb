class CartStepsController < ApplicationController
  before_filter :load_and_authorize_cart
  before_filter :load_and_authorize_step
  
  layout :set_layout
  
  rescue_from Pundit::NotAuthorizedError do
    redirect_to cart_path
  end
        
  def show
    @step = CartStepDecorator.decorate(@step)
    respond_to do |format|
      format.html { render "#{@step.to_param}" }
      format.json { render json: @cart }
    end
  end

  def update
    @step = CartStepDecorator.decorate(@step)
    respond_to do |format|
      if @step.update_attributes(step_params)
        @step.reload
        if proceed_to_next_step?
          format.html { redirect_to next_resource }
        else
          format.html { render @step.to_param }
        end
        format.json { head :ok }
      else
        format.html { render @step.to_param }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    
  def next_resource
    if @step.next.present?
      @step.next
    elsif @step.order.present?
      order_path @step.order
    else
      raise "EpicFial: lolwut while creating order."
    end
  end
    
  def set_layout
    request.xhr? ? false : "application"
  end
  
  def load_and_authorize_step
    @step = @cart.steps.find(params[:id])
    @step.valid? if @step.to_param == "fresh"
    authorize @step
  end
  
  def load_and_authorize_cart
    @cart = current_cart
    authorize @cart
  end
  
  def proceed_to_next_step?
    !request.xhr?
  end
  
  def step_params
    params.require(:cart_step).permit(permitted_params)
  end
  
  def permitted_params
    case @step.to_param
      when "fresh"
        {checked_bargain_ids: [],
         items_attributes: 
          [:quantity, :_destroy, :id, :product_type, :product_id]}
      when "authentication" then [:email]
      when "shipping_and_payment"
        [:payment_method,
         :shipping_method,
         :invoice,
         :custom_billing_address,
         :comment,
         shipping_address_attributes:
          [:first_name, :last_name, :postal_code, :phone_number,
           :street_and_number, :city],
        billing_address_attributes:
          [:city, :country, :postal_code, :first_name, :last_name,
           :street_and_number, :company_name, :company_nip]]   
      when "confirmation" then [:terms]
    end
  end
end
