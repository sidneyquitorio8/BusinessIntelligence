$(document).ready(function() {

	var filters = [];
	// var store = {};
	// store['dimension'] = 'store';
	// store['attributes'] = ["state", "city"];
	// store['choices'] = ['San Jose', 'San Francisco'];
	// filters.push(store);

	//used for checking if the dimension is already in the filter
	function dimensionInFilter(dimension) {
		index = -1;
		for(var i = 0; i < filters.length; i++) {
			if(filters[i].dimension == dimension) {
				index = i;
				return index;
			}
		}
		return index;
	}

	//hides or shows the attributes of a dimension & also sets up the filters
	function dimensionClick(dimension, event) {
		dimension_name = dimension + "_dimension";
		dimension_attributes = dimension + "_attributes";
		if( event.target.id == dimension_name ) {
			if($('.' + dimension_attributes).attr('style') == 'visibility:hidden' ) {
				$('.' + dimension_attributes).attr('style', '');
				//if button is now blue, add to filter if it is not there
				if($(event.target).hasClass('btn-primary') ) {
					if( dimensionInFilter(dimension) <= -1 ) {
						hash = {};
						hash['dimension'] = dimension;
						filters.push(hash);
					}
				}
			}
			else {
				$('.' + dimension_attributes).attr('style', 'visibility:hidden');
				//if button is now white, remove from filter if it is there
				if($(event.target).hasClass('btn-default') ) {
					if( dimensionInFilter(dimension) > -1 ) {
						index = dimensionInFilter(dimension);
						filters.splice(index, 1);
					}
				}
			}
		}		
	}

	//dimension handler
	$(".dimension").click(function(event) {
		//change dimension colors
		if($(event.target).hasClass('btn-default') ) {
			$(event.target).removeClass('btn-default').addClass('btn-primary');
		}
		else {
			$(event.target).removeClass('btn-primary').addClass('btn-default');
		}

		//hide or show store attributes & add or remove store from filters
		if( event.target.id == 'store_dimension' ) {
			dimensionClick("store", event);

			// if($('.store_attributes').attr('style') == 'visibility:hidden' ) {
			// 	$('.store_attributes').attr('style', '');
			// 	//if button is now blue, add to filter if it is not there
			// 	if($(event.target).hasClass('btn-primary') ) {
			// 		if( dimensionInFilter('store') <= -1 ) {
			// 			store = {};
			// 			store['dimension'] = 'store';
			// 			filters.push(store);
			// 		}
			// 	}
			// }
			// else {
			// 	$('.store_attributes').attr('style', 'visibility:hidden');
			// 	//if button is now white, remove from filter if it is there
			// 	if($(event.target).hasClass('btn-default') ) {
			// 		if( dimensionInFilter('store') > -1 ) {
			// 			index = dimensionInFilter('store');
			// 			filters.splice(index, 1);
			// 		}
			// 	}
			// }
		}

		//hide or show product attributes
		else if( event.target.id == 'product_dimension' ) {
			dimensionClick("product", event);
		}

		//hide or show product attributes
		else if( event.target.id == 'time_dimension' ) {
			dimensionClick("time", event);
		}
	});

	//attribute handler
	$(".attribute").click(function(event) {
		//change dimension colors
		if($(event.target).hasClass('btn-default') ) {
			$(event.target).removeClass('btn-default').addClass('btn-primary');
		}
		else {
			$(event.target).removeClass('btn-primary').addClass('btn-default');
		}
	});


	
});