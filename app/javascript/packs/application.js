// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
$(document).ready(function(){
	console.log('toto');

  $('#add_address').on('click', function(e){
    e.preventDefault();

    var $parent_div = $('#add_address').parent('.add_address_link_container');
    var $parent_div_prev_siblings = $parent_div.prevAll('.field'); // remember this has it in desc order

    // 2 because address has 2 attributes (:city, :zip)
    var $div_with_all_address_fields = $($parent_div_prev_siblings.slice(0, 2).get().reverse())
    // we are "getting" so we can reverse so we have it in asc order again, and then we convert to jquery object


    $div_with_all_address_fields.each(function(index, address_field_label_input_group) {
      var $aflip = $(address_field_label_input_group);

      var prev_input_id = $aflip.find('input').attr('id'); // example: author_addresses_attributes_3_city
      var prev_input_index = prev_input_id.split('_').find(element => !isNaN(element)) // find index of element, its the number in the example above
      var prev_input_name = $aflip.find('input').attr('name');

      var $new_aflip = $aflip.clone();
      var regexp = new RegExp(prev_input_index, "gi");

      var new_input_index = (parseInt(prev_input_index) + 1).toString();
      var new_input_id = prev_input_id.replace(regexp, new_input_index);
      var new_input_name = prev_input_name.replace(regexp, new_input_index);

      $new_aflip.find('label').attr('for', new_input_id);
      $new_aflip.find('input').attr({id: new_input_id, name: new_input_name, value: ''});

      $('.add_address_link_container').before($new_aflip[0]);
    });

  });

  $('.delete_address').on('click', function(e){
    e.preventDefault();
    var $parent_container = $(this).parent('.delete_address_container');
    var address_id = $parent_container.nextAll('input[type=hidden]').first().val();
    var $divs_to_fade_out = $parent_container.nextAll('.field').slice(0, 2);
    // slice can take up to 2 args
    // 1 arg = start array at index arg1
    // 2 arg = start array at index arg1 and ending in index arg2

    $.ajax({
      url: `/addresses/${address_id}.json`,
      type: 'DELETE',
      contentType: 'application/json',
      dataType: 'json',
      // data: JSON.stringify({address: {city: 'John', zip: 'Doe'} }), // This is just for syntax, mostly used for POST requests
      success: function(result) {
        $parent_container.fadeOut();
        $divs_to_fade_out.fadeOut();
      },
      error: function(err) {
        console.log(`error: ${err.responseText}`);
      }
    });

  });

  $('#add_new_company').on('click', function(e){
    e.preventDefault();
    $cloned_div = $('.company_div').first().clone();
    div_to_insert = $cloned_div.prop('outerHTML');
    $('#add_new_company').before(div_to_insert);
  });

});
