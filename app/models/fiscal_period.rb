class FiscalPeriod
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name

  has_many :budget_line_items
end
