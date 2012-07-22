class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :total_expenditure, type: Integer, :default => 0
  field :total_revenue, type: Integer, :default => 0

  has_many :budget_line_items, :dependent => :destroy
end
