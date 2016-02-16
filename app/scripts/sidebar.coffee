setSidebar = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject) and !_.isUndefined(window.thematicMaps)
    compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
    $('#project-elements').html(compiled(elementsProject:window.elementsProject))

    compiledHelp = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/help.tpl'))
    $('#help').html(compiledHelp())

    compiledLegend = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/legend.tpl'))
    $('#legend').html(compiledLegend(geoServerLegendLink: window.geoServerLegendLink, "legends": window.legends))

    compiledBasemap = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/basemap.tpl'))
    $('#basemap').html(compiledBasemap(baseMaps: window.baseMaps))

    compiledThematicMaps = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/thematic-maps.tpl'))
    $('#thematic-maps').html(compiledThematicMaps(thematicMaps: window.thematicMaps))

    clearInterval(setSidebar)
  return
), 100)




