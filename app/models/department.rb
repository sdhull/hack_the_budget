class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name

  embedded_in :budget_line_item
end
