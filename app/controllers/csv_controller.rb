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
        revenue: row['Revenue'],
        expenditure: row['Expenditure']        
      )
      line_item.build_department(
        name: row['Department']
      )
      line_item.build_cost_center(
        name: row['Cost Center Name'],
        code: row['Cost Center Code']
      )
      line_item.save
    end
    flash[:notice] = "CSV uploaded"
    redirect_to :back 
  end
end