class BudgetLineItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :revenue, type: Integer, :default => 0
  field :expenditure, type: Integer, :default => 0

  belongs_to :cost_center
  belongs_to :department
  belongs_to :fiscal_period
end
