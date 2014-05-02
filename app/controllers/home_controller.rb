class HomeController < ApplicationController
  def index
 	# sql = "Select distinct(city) from store"
	# records_array = ActiveRecord::Base.connection.execute(sql)

	store_attributes = ['name','store_number','store_street_address','city','store_county','store_state','store_zip','sales_district','sales_region','store_manager','store_phone','store_FAX','floor_plan_type','photo_processing_type','finance_services_type','first_opened_date','last_remodel_date','store_sqft','grocery_sqft','frozen_sqft','meat_sqft']
	product_attributes = ['description', 'full_description', 'SKU_number', 'package_size', 'brand', 'subcategory', 'category','department','package_type','diet_type','weight','weight_unit_of_measure','units_per_retail_case','cases_per_pallet','shelf_width_cm','shelf_height_cm','shelf_depth_cm']
	time_attributes = ['date','day_of_week','day_number_in_month','day_number_overall','week_number_in_year','week_number_overall','Month','quarter','fiscal_period','year','holiday_flag']

  end

  def test1
  end

  def sql
  	# debugger
  	
	# params['filters']
	# {"0"=>{"dimension"=>"store", "attributes"=>["store_state", "store_street_address"], "choices"=>{"store_state"=>["CA", "NY"], "store_street_address"=>["1 Washington Square", "12 Twin Dolphin Rd"]}}, "1"=>{"dimension"=>"product", "attributes"=>["brand", "subcategory"], "choices"=>{"brand"=>["Kellog", "Kraft"], "subcategory"=>["Candy"]}}}

	# params['filters']['0']
	# {"dimension"=>"store", "attributes"=>["store_state", "store_street_address"], "choices"=>{"store_state"=>["CA", "NY"], "store_street_address"=>["1 Washington Square", "12 Twin Dolphin Rd"]}}
	# params['filters']['1']
	# {"dimension"=>"product", "attributes"=>["brand", "subcategory"], "choices"=>{"brand"=>["Kellog", "Kraft"], "subcategory"=>["Candy"]}}


	# params['filters']['1']['dimension']
	# "product"
	# params['filters']['1']['choices']['brand']
	# ["Kellog", "Kraft"]
	# params['filters']['1']['choices']['brand'][0]
	# "Kellog"


  	@sql = "DUMMY".to_json
  	render json: @sql
  end
end
