require 'csv'

class CsvController < ApplicationController

  def import
  end

  def upload
    Department.delete_all # cascading delete to all BudgetLineItems
    CostCenter.delete_all
    fiscal_period = FiscalPeriod.first || FiscalPeriod.create
    uploaded_csv = params[:csv]
    csv_file = Tempfile.open('uploads', Rails.root.join('tmp')) do |file|
      file.write(uploaded_csv.read)
      file.flush
    end
    CSV.foreach(csv_file, :headers => true) do |row|
      line_item = BudgetLineItem.new(
        revenue: row['Revenue'].to_f,
        expenditure: row['Expenditure'].to_f
      )
      department = Department.find_or_initialize_by(:name => row['Department'].try(:strip))
      department.total_expenditure += line_item.expenditure
      department.total_revenue += line_item.revenue
      department.save
      line_item.department = department

      cost_center = CostCenter.find_or_initialize_by(
        name: row['Cost Center Name'].try(:strip),
        code: row['Cost Center Code'].try(:strip)
      )
      cost_center.total_expenditure += line_item.expenditure
      cost_center.total_revenue += line_item.revenue
      line_item.cost_center = cost_center
      line_item.save
    end
    flash[:notice] = "CSV uploaded"
    redirect_to :back
  end
end
