class BudgetLineItemsController < ApplicationController
  respond_to :json
  def index
    @budget_line_items = BudgetLineItem.all
    @budget_line_items.sort do |a|
      [a.expenditure]
    end
    
    respond_with @budget_line_items
  end
end
