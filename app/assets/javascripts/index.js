$(document).ready(function() {

	var filters = [];

	// var store = {};
	// store['dimension'] = 'store';
	// store['attributes'] = ["store_state", "store_street_address"];
	// store['choices'] = {};
	// store['choices']['store_state'] = ['CA', 'NY'];
	// store['choices']['store_street_address'] = ['1 Washington Square', '12 Twin Dolphin Rd'];
	// filters.push(store);

	// var product = {};
	// product['dimension'] = 'product';
	// product['attributes'] = ["brand", "subcategory"];
	// product['choices'] = {};
	// product['choices']['brand'] = ['Kellog', 'Kraft'];
	// product['choices']['subcategory'] = ['Candy'];
	// filters.push(product);

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
				//hide dimension attributes and make them white
				$('.' + dimension_attributes).removeClass('btn-primary').addClass('btn-default');
				$('.' + dimension_attributes).attr('style', 'visibility:hidden');

				//uncheck associated checkboxes
				$('.choice.' + dimension).prop('checked', false);

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
		if($(this).hasClass('btn-default') ) {
			$(this).removeClass('btn-default').addClass('btn-primary');
		}
		else {
			$(this).removeClass('btn-primary').addClass('btn-default');
		}

		dimension = $(this).data('dimension');
		dimensionClick(dimension,event);
	});

	//attribute handler
	$(".attribute").click(function(event) {
		//change dimension colors
		if($(this).hasClass('btn-default') ) {
			$(this).removeClass('btn-default').addClass('btn-primary');
		}
		else {
			$(this).removeClass('btn-primary').addClass('btn-default');
		}
		//add the clicked attribute to the corresponding dimension filter
		dimension = $(this).data('dimension');

		index = dimensionInFilter(dimension);
		//if button is now blue add it to filter
		if($(this).hasClass('btn-primary') ) {
			if( filters[index]['attributes'] == null) {
				filters[index]['attributes'] = [];
			}
			filters[index]['attributes'].push(this.id);

			//show modal
			$('#' + this.id +'_modal').modal('show');
		}
		else if( $(this).hasClass('btn-default') ) {
			attribute_index = filters[index]['attributes'].indexOf(this.id);
			filters[index]['attributes'].splice(attribute_index, 1);

			//uncheck associated checkboxes
			$('.choice.' + this.id).prop('checked', false);

		}
	});

	//choice handler
	$(".choice").click(function(event) {
		//add the checked choice to filter
		attribute = $(this).data('column');
		dimension = $(this).data('dimension');
		if(this.checked) {
			index = dimensionInFilter(dimension);
			if( filters[index]['choices'] == null) {
				filters[index]['choices'] = {};
			}
			if(filters[index]['choices'][attribute] == null) {
				filters[index]['choices'][attribute] = [];
			}
			filters[index]['choices'][attribute].push($(this).val());
		}
		else { //removed choice from filter
			choice_index = filters[index]['choices'][attribute].indexOf($(this).val());
			filters[index]['choices'][attribute].splice(choice_index,1);
		}
	});

	$('#submit_query').click(function(event) {
		$.ajax({
		    type: "GET",
		    dataType: 'json',
		    url: "/sql",
		    data: {
		        filters: filters
		    },
		    success: function(response) {
		        $('#sql').append(response);
		    }
    	});
	});
	
});