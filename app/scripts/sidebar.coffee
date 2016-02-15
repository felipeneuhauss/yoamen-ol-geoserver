setSidebar = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)
    compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
    $('#project-elements').html(compiled(elementsProject:window.elementsProject))

    compiledHelp = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/help.tpl'))
    $('#help').html(compiledHelp())


    compiledLegend = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/legend.tpl'))
    $('#legend').html(compiledLegend(geoServerLegendLink: window.geoServerLegendLink, "legends": window.legends))
    clearInterval(setSidebar)
  return
), 100)
