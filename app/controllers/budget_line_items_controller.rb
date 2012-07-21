class BudgetLineItemsController < ApplicationController
  respond_to :json
  def index
    @budget_line_items = BudgetLineItem.all
    respond_with @budget_line_items
  end
end
