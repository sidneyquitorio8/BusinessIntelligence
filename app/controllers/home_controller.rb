class HomeController < ApplicationController
  def index
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


  	@sql = "DUMMY"
  	render json: @sql
  end
end
