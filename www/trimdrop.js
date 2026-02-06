shinyjs.init = function(){
	$( ".rhandsontable" ).on("click", function(event) {
  hot1 = $('#' + event.currentTarget.id); 
  hot1[0].htmlwidget_data_init_result.hot.updateSettings({trimDropdown: false });
});
}
