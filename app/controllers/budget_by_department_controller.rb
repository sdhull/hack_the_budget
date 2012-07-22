class BudgetByDepartmentController < ApplicationController
  def index
    query_string = <<-RAW_QUERY

    // make sure we're using the right db; this is the same as "use aggdb;" in shell
    db = db.getSiblingDB("hackoakbudget2");

    // grouping
    var g1 = db.runCommand(
    { aggregate : "budget_line_items", pipeline : [
        { $project : {
    	revenue : 1,
    	expenditure : 1,
    	cost_center : 1,
    	department : 1
        }},
        { $group : {
    	_id : "$cost_center.name",
    	line_item_count : { $sum : 1 },
    	total_revenue : { $sum : "$revenue" },
    	total_expenditure : { $max : "$expenditure" }
        }}
    ]});

    var g2 = db.runCommand(
    { aggregate : "budget_line_items", pipeline : [
        { $project : {
    	revenue : 1,
    	expenditure : 1,
    	cost_center : 1,
    	department : 1
        }},
        { $group : {
    	_id : "$department.name",
    	line_item_count : { $sum : 1 },
    	total_revenue : { $sum : "$revenue" },
    	total_expenditure : { $max : "$expenditure" }
        }}
    ]});

    return g2

    RAW_QUERY

    # Mongoid.default_session.send(:current_database).command(:eval => query_string )['retval']['result']
    render :json => Department.all
  end
end
