require 'csv'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

csv = <<EOF
Cost Center Code,Cost Center Name,Department,Revenue,Expenditure
1010,General Fund: General Purpose,Mayor,0,1140011
1010,General Fund: General Purpose,City Council,,1998443
1010,General Fund: General Purpose,City Administrator,940450,12255415
1010,General Fund: General Purpose,City Attorney,87030,4070869
1010,General Fund: General Purpose,City Auditor,,885773
1010,General Fund: General Purpose,City Clerk,34260,1394452
1010,General Fund: General Purpose,Human Resources,,3977754
1010,General Fund: General Purpose,Office of Communications and Information Services,2388740,7489612
1010,General Fund: General Purpose,Finance and Management Agency,365112153,19503491
1010,General Fund: General Purpose,Police Services Agency,5127694,155082878
1010,General Fund: General Purpose,Library,7881590,91666666
1010,General Fund: General Purpose,Office of Parks and Recreation,766240,9061135
1010,General Fund: General Purpose,Department of Human Services,2040118,12193111
1010,General Fund: General Purpose,Public Works Agency,125830,4527780
1010,General Fund: General Purpose,Community and Economic Development Agency,2210,472759
1010,General Fund: General Purpose,Non Departmental and Port,29452170,65637785
1010,General Fund: General Purpose,Capital Improvement Projects,720360,252000
EOF

fiscal_period = FiscalPeriod.first || FiscalPeriod.create

csv_file = Tempfile.open('uploads', Rails.root.join('tmp')) do |file|
    file.write(csv)
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