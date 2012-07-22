require 'csv'

class CsvController < ApplicationController

  def import
  end

  def upload
    Department.destroy_all # cascading destroy to all BudgetLineItems
    CostCenter.delete_all
    fiscal_period = FiscalPeriod.first || FiscalPeriod.create
    uploaded_csv = params[:csv]
    csv_file = Tempfile.open('uploads', Rails.root.join('tmp')) do |file|
      file.write(uploaded_csv.read)
      file.flush
    end
    count = 0
    CSV.foreach(csv_file, :headers => true) do |row|
      count += 1
      line_item = BudgetLineItem.new(
        revenue: row['Revenue'].to_s.gsub(/,|\s*|"*/,'').to_i,
        expenditure: row['Expenditure'].to_s.gsub(/,|\s*|"/,'').to_i
      )
      department = Department.find_or_initialize_by(:name => row['Department'].to_s.gsub(/"*/, '').strip)
      department.total_expenditure += line_item.expenditure
      department.total_revenue += line_item.revenue
      line_item.department = department
      department.save!

      cost_center = CostCenter.find_or_initialize_by(
        name: row['Cost Center Name'].to_s.gsub(/"*/, '').strip,
        code: row['Cost Center Code'].to_s.gsub(/"*/, '').strip
      )
      cost_center.total_expenditure += line_item.expenditure
      cost_center.total_revenue += line_item.revenue
      line_item.cost_center = cost_center
      cost_center.save!
      line_item.save!
    end
    flash[:notice] = "CSV uploaded: #{count} budget line items imported"
    redirect_to :back
  end
end
