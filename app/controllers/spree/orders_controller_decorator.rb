Spree::OrdersController.class_eval do
  def bag
    respond_with do |format|
      format.html{}
      format.js{ render :layout => false }
    end
  end
end
