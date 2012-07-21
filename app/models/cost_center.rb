class CostCenter
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code
  field :name

  embedded_in :budget_line_item
end
