class HomeController < ApplicationController

  def index
	sql = "Select distinct(city) from store"
	records_array = ActiveRecord::Base.connection.execute(sql)

	store_attributes = ['name','store_number','store_street_address','city','store_county','store_state','store_zip','sales_district','sales_region','store_manager','store_phone','store_FAX','floor_plan_type','photo_processing_type','finance_services_type','first_opened_date','last_remodel_date','store_sqft','grocery_sqft','frozen_sqft','meat_sqft']
	product_attributes = ['description', 'full_description', 'SKU_number', 'package_size', 'brand', 'subcategory', 'category','department','package_type','diet_type','weight','weight_unit_of_measure','units_per_retail_case','cases_per_pallet','shelf_width_cm','shelf_height_cm','shelf_depth_cm']
	time_attributes = ['date','day_of_week','day_number_in_month','day_number_overall','week_number_in_year','week_number_overall','Month','quarter','fiscal_period','year','holiday_flag']

	@checkboxes = []
	store_attributes.each do |attribute|
  	sql = "Select distinct(#{attribute}) from store"
  	records_array = ActiveRecord::Base.connection.execute(sql)
  	hash = {}
  	hash['dimension'] = "store"
  	hash['attribute'] = attribute
  	hash['choices'] = records_array
  	@checkboxes << hash
	end

	product_attributes.each do |attribute|
  	sql = "Select distinct(#{attribute}) from product"
  	records_array = ActiveRecord::Base.connection.execute(sql)
  	hash = {}
  	hash['dimension'] = "product"
  	hash['attribute'] = attribute
  	hash['choices'] = records_array
  	@checkboxes << hash
	end

	time_attributes.each do |attribute|
  	sql = "Select distinct(#{attribute}) from time"
  	records_array = ActiveRecord::Base.connection.execute(sql)
  	hash = {}
  	hash['dimension'] = "time"
  	hash['attribute'] = attribute
  	hash['choices'] = records_array
  	@checkboxes << hash
	end
  end

  def test1
  end

  def sql

	sqlDims= ""
	sqlAttr= ""
	sqlwhere=""
	sqlwhereChoice = ""
	flag = 0
	#must always initialize

	filters = params['filters']
	# sqlDims
	filters.each do |result|
	  dimension = result[1]['dimension']
	#debugger
	sqlDims += dimension + ", "
	#debugger
	end

	#currDim is always nil?
	#i think result[1] only works with a each-do loop
	 # sqlAttr
	filters.each do |result|
		attributes = result[1]['attributes']
		   # debugger
		  if (attributes.nil?)
			currDim = result[1]['dimension'].to_s
		 	# debugger
		  if (currDim == "time")
			sqlAttr = sqlAttr + "week_number_in_year, "
		  end
		  if (currDim == "store")
			sqlAttr = sqlAttr + "city, "
		  end
		  if (currDim == "product")
			sqlAttr = sqlAttr + "subcategory, "
		  end
			else
			attributes.each do |attribute|
			sqlAttr += attribute + ", "
		  end #END if(attributes.nil?)
		end #END attributes
	end #END filters.each


	filters.each do |result|
	attributes = result[1]['attributes']
      	if(!attributes.nil?)
      	choices = result[1]['choices']
        	if(!choices.nil?)
	 			# debugger
	          	choices.each do |key, array|
					# debugger
	            	sqlwhereChoice += " and ("
	            	array.each_with_index do |value, index|
						# debugger
		              	if(array.length != index+1)
		              		if(!value.is_a?(Numeric))
		              			sqlwhereChoice += key + "='" + value + "' or "
		  						# debugger
		                  	else
		                  		sqlwhereChoice += key + "=" + value + " or "
		  						# debugger
		              		end #if(!value.is_?(Numeric))
		                else
		                  	if(!value.is_a?(Numeric))
		                      	sqlwhereChoice += key + "='" + value + "') "
								# debugger
		                    else
		                      	sqlwhereChoice += key + "=" + value + ") "
							# debugger
		                  	end #if(!value.is_?(Numeric))
		              	end #if(array.length != index+1)
	            	end #array.each_with_index do |value, index|
	          	end #choices.each do |key, array|
        	end #if (!choices.nil?)
      	end #if (!attributes.nil?)
	end #filters.each do |result|

	#debugger
	if((sqlDims.include?"store") && (sqlDims.include?"product") && (sqlDims.include?"time"))
	  sqlwhere= "where product.product_key = `sales fact`.product_key and store.store_key = `sales fact`.store_key and time.time_key = `sales fact`.time_key "
	elsif((sqlDims.include?"store") && (sqlDims.include?"product"))
	  sqlwhere= "where product.product_key = `sales fact`.product_key and store.store_key = `sales fact`.store_key "
	elsif((sqlDims.include?"product") && (sqlDims.include?"time"))
	  sqlwhere= "where product.product_key = `sales fact`.product_key and time.time_key = `sales fact`.time_key "
	elsif((sqlDims.include?"store") && (sqlDims.include?"time"))
	  sqlwhere= "where store.store_key = `sales fact`.store_key and time.time_key = `sales fact`.time_key "
	elsif((sqlDims.include?"store"))
	  sqlwhere= "where store.store_key = `sales fact`.store_key "
	elsif((sqlDims.include?"product"))
	  sqlwhere= "where product.product_key = `sales fact`.product_key "
	elsif((sqlDims.include?"time"))
	  sqlwhere= "where time.time_key = `sales fact`.time_key "
	end
	#debugger
	sqlstring =
	"select " + sqlAttr + " ROUND(SUM(dollar_sales), 2) as 'Sales in Dollars' " + "\n" +
	"from " + sqlDims + "`sales fact` " + "\n" +
	sqlwhere + sqlwhereChoice + "\n" +
	"group by " + sqlAttr

	sqlstring = sqlstring[0, sqlstring.length-2]
	 @sql = sqlstring.to_json

	# 	sqltable = ActiveRecord::Base.connection.execute(sqlstring)
	# @sql = sqltable.to_json

	client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => 'businessintelligence_dev')
	results = client.query(sqlstring)
	@hash = {}
	@hash['query'] = sqlstring
	@hash['count'] = results.count
	@hash['headers'] = results.fields
	@hash['results'] = results

	# @records_array = ActiveRecord::Base.connection.execute(sqlstring)
	render json: @hash
	end
end
