shinyjs.ShowHideRoadOpts = function(params) {
	 var defaultParams = {
    minOpts : 1,
    maxOpts : 10,
    numOpts : 2
  };

  params = shinyjs.getParams(params, defaultParams);
  var numOpts2 = parseInt(params.numOpts) + 1
  var maxOpts2 = parseInt(params.maxOpts) + 1

for (var i = params.minOpts; i <= params.numOpts; i++) {
  var prnt_show = $('li.treeview ul[data-expanded=\"RoadOption' + i + '\"]').parent().show();
  var chld_show = $('li.treeview ul[data-expanded=\"RoadOption' + i + '\"]').children().show();
  console.log(prnt_show);
  console.log(chld_show);
}

for (var j = numOpts2; j <= params.maxOpts; j++) {
  var prnt_hide = $('li.treeview ul[data-expanded=\"RoadOption' + j + '\"]').parent().hide();
  var chld_hide = $('li.treeview ul[data-expanded=\"RoadOption' + j + '\"]').children().hide();
  console.log(prnt_hide);
  console.log(chld_hide);
}
}

shinyjs.ShowHideRailOpts = function(params) {
	 var defaultParams = {
    minOpts : 1,
    maxOpts : 10,
    numOpts : 2
  };

  params = shinyjs.getParams(params, defaultParams);
  var numOpts2 = parseInt(params.numOpts) + 1
  var maxOpts2 = parseInt(params.maxOpts) + 1

for (var i = params.minOpts; i <= params.numOpts; i++) {
  var prnt_show = $('li.treeview ul[data-expanded=\"LightRailOption' + i + '\"]').parent().show();
  var chld_show = $('li.treeview ul[data-expanded=\"LightRailOption' + i + '\"]').children().show();
  console.log(prnt_show);
  console.log(chld_show);
}

for (var j = numOpts2; j <= params.maxOpts; j++) {
  var prnt_hide = $('li.treeview ul[data-expanded=\"LightRailOption' + j + '\"]').parent().hide();
  var chld_hide = $('li.treeview ul[data-expanded=\"LightRailOption' + j + '\"]').children().hide();
  console.log(prnt_hide);
  console.log(chld_hide);
}
}


shinyjs.ShowHideGreenwayOpts = function(params) {
	 var defaultParams = {
    minOpts : 1,
    maxOpts : 10,
    numOpts : 2
  };

  params = shinyjs.getParams(params, defaultParams);
  var numOpts2 = parseInt(params.numOpts) + 1
  var maxOpts2 = parseInt(params.maxOpts) + 1

for (var i = params.minOpts; i <= params.numOpts; i++) {
  var prnt_show = $('li.treeview ul[data-expanded=\"GreenwayOption' + i + '\"]').parent().show();
  var chld_show = $('li.treeview ul[data-expanded=\"GreenwayOption' + i + '\"]').children().show();
  console.log(prnt_show);
  console.log(chld_show);
}

for (var j = numOpts2; j <= params.maxOpts; j++) {
  var prnt_hide = $('li.treeview ul[data-expanded=\"GreenwayOption' + j + '\"]').parent().hide();
  var chld_hide = $('li.treeview ul[data-expanded=\"GreenwayOption' + j + '\"]').children().hide();
  console.log(prnt_hide);
  console.log(chld_hide);
}
}