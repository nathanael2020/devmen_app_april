module Spree
  class ShippingMethodsController < Spree::StoreController

    layout nil

    ssl_allowed :index

    respond_to :json

    def index

      if params["use_billing"].to_s == 'false' # used ship address
        if params.has_key?(:ship_address_id) && params[:ship_addres_id].to_i > 0
          spree_current_user.addresses.where(:id => params[:ship_addres_id]).first
        else
          current_order.ship_address = Address.default
        end
      else  # used ship address
        if params.has_key?(:bill_address_id) && params[:bill_addres_id].to_i > 0
          spree_current_user.addresses.where(:id => params[:bill_addres_id]).first
        else
          current_order.ship_address = Address.default
        end

      end

      render :json => current_order.rate_hash
    end

  end

end
