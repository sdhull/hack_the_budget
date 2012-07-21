class BudgetLineItem
  include Mongoid::Document
  include Mongoid::Timestamps
  field :revenue, type: Float
  field :expenditure, type: Float

  embeds_one :cost_center
  embeds_one :department
  belongs_to :fiscal_period
end
