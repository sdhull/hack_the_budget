require 'csv'

class CsvController < ApplicationController
  
  def import
  end
  
  def upload
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
      line_item.build_department(
        name: row['Department'].strip
      )
      line_item.build_cost_center(
        name: row['Cost Center Name'].strip,
        code: row['Cost Center Code'].strip
      )
      line_item.save
    end
    flash[:notice] = "CSV uploaded"
    redirect_to :back 
  end
end