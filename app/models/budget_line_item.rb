class BudgetLineItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :revenue, type: Float
  field :expenditure, type: Float

  belongs_to :cost_center
  belongs_to :department
  belongs_to :fiscal_period
end
