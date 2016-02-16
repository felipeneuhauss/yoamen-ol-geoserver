#console.log '\'Allo \'Allo!'
#console.log 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siga:CI_CANTEIRO_OBRA&outputFormat=text/javascript&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=9816'

# eslint-disable-line no-console
window.loadFeatures = (response) ->
  vectorSource.addFeatures geojsonFormat.readFeatures(response)
  return

# Get FCA Styles
getStyles = ()->
  response = $.ajax(
    url: '/geo-styles/style.json',
    dataType: 'json',
    async: false,
    success: (data) ->
      return data.responseJSON
  )

  return response.responseJSON

# Configura os basemaps
getBaseMaps = () ->
  layersMapa      = []
  window.baseMaps = []

  layersMapa = [
    new ol.layer.Tile(
      style: 'Base'
      source: new ol.source.OSM())
    new (ol.layer.Tile)(
      style: 'Road'
      source: new (ol.source.MapQuest)(layer: 'osm'))
    new (ol.layer.Tile)(
      style: 'Aerial'
      visible: false
      source: new (ol.source.MapQuest)(layer: 'sat'))
    new (ol.layer.Group)(
      style: 'AerialWithLabels'
      visible: false
      layers: [
        new (ol.layer.Tile)(source: new (ol.source.MapQuest)(layer: 'sat'))
        new (ol.layer.Tile)(source: new (ol.source.MapQuest)(layer: 'hyb'))
      ])
  ]

  # Informacoes para serem mostradas no menu lateral
  window.baseMaps.push(id: 'Base', name: 'Básico')
  window.baseMaps.push(id: 'Road', name: 'Estradas')
  window.baseMaps.push(id: 'Aerial', name: 'Terreno')
  window.baseMaps.push(id: 'AerialWithLabels', name: 'Terreno com legendas')

  window.layers = layersMapa

###*
# Add ao projeto as layers das estruturas do projeto
###
addElementsProjectLayers = (data, styles) ->
  # Para cada estrutura vai ao geoserver pega as features
  data.forEach((el, index)->

    #if el.ttTpEstrutura.noTabelaEstrutura == 'CI_CANTEIRO_OBRA'
    urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:'+ el.ttTpEstrutura.noTabelaEstrutura+'&maxFeatures=50&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO='+$('#empreendimentoId').val()+'&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857'

    structureStyle = _.find styles, (elem) ->
      elem.id == el.ttTpEstrutura.noTabelaEstrutura

    # format used to parse WFS GetFeature responses
    geojsonFormat = new (ol.format.GeoJSON)
    vectorSource = new (ol.source.Vector)(loader: (extent, resolution, projection) ->
      #8854
      $.ajax
        url: urljson
        dataType: 'jsonp'
        jsonCallback: 'parseResponse'
      return
    )

    ###*
    # JSONP WFS callback function.
    # @param {Object} response The response object.
    ###

    window.loadFeatures = (response) ->
      vectorSource.addFeatures geojsonFormat.readFeatures(response)
      return

    # {"id": "CI_AREA_ESTUDO", "stroke": "#FF0000", "strokeWidth": 1.5, "fill": "transparent"},
    vector = new (ol.layer.Vector)(
      id: el.ttTpEstrutura.noTabelaEstrutura
      source: vectorSource
      style: new (ol.style.Style)(
        fill: new (ol.style.Fill)(
          color: if !_.isUndefined(structureStyle.fill) then structureStyle.fill else null
          opacity: if !_.isUndefined(structureStyle.fillOpacity) then structureStyle.fillOpacity else null)
        stroke: new (ol.style.Stroke)(
          color: if !_.isUndefined(structureStyle.stroke) then structureStyle.stroke else null
          width: if !_.isUndefined(structureStyle.strokeWidth) then structureStyle.strokeWidth else 0)))

    # Add a layer ao projeto
    window.layers.push(vector)

    # Inicializa as variaveis para a sidebar
    window.legends.push("element":el.ttTpEstrutura.noTabelaEstrutura, "elementName": el.ttTpEstrutura.noTpEstrutura)
    window.elementsProject.push("element":el.ttTpEstrutura.noTabelaEstrutura, "elementName": el.ttTpEstrutura.noTpEstrutura, "elementInfo": el.ttTpEstrutura.dsInfoEstrutura)
  )

###*
#  Funcao que add os mapas tematicos
###
addThematicMapsLayers = (styles) ->
  thematicMaps = [{id:'CB_AMAZONIA_LEGAL',name: 'Amazônia Legal'},
                   {id:'CB_UNIDADE_CONSERVACAO',name: 'Unidade de Conservação'},
#                   {id:'CB_DIVISAO_HIDROGRAFICA',name: 'Divisão Hidrográfica'},
                   {id:'CB_HIDROGRAFIA',name:'Hidrografia'},
                   {id:'CB_MASSA_DAGUA',name:'Massa D\'água'},
                   {id: 'CB_TERRA_INDIGENA',name: 'Terra Indígena'},
                   {id: 'CB_UNIDADE_FEDERACAO',name: 'Unidade da Federação'},
                   {id: 'CB_MUNICIPIO',name: 'Município'}]

  for thematicMap in thematicMaps
    urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:'+ thematicMap.id+'&maxFeatures=50&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO='+$('#empreendimentoId').val()+'&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857'

    styleName = thematicMap.id
    styleName = styleName.replace('CB_', '')
    structureStyle = _.find styles, (elem) ->
      elem.id == styleName

    wms = new (ol.layer.Image)(
      id: thematicMap.id
      source: new (ol.source.ImageWMS)(
        url: 'http://10.1.25.80:10001/geoserver/wms'
        params: 'LAYERS': 'siga:'+thematicMap.id
        serverType: 'geoserver'))

    # Esconde a layer
    wms.setVisible(false)

    # Add a layer ao projeto
    window.layers.push(wms)

    # Inicializa as variaveis para a sidebar
    window.thematicMaps.push("element":thematicMap.id, "elementName": thematicMap.name, "elementInfo": thematicMap.name)


###*
# Funcao que cria o mapa
#
###

createMap = () ->

  window.geoServerLegendLink = "http://10.1.25.80:10001//geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&layer="

  urlJson = window.location.origin+'/empreendimento.json'

  $.getJSON urlJson, (data) ->

    window.enterprises     = data
    window.legends         = []
    window.elementsProject = []
    window.thematicMaps    = []

    styles = getStyles()

    getBaseMaps()

    addElementsProjectLayers(data, styles)
    # Add thematic maps to layers
    addThematicMapsLayers(styles)

    # Cria o mapa com as layers
    window.map = new ol.Map(
      layers: window.layers,
      target: 'map',
      view: new ol.View(
        center: [-6019652.779802445, -1708175.0676016365],
        zoom: 4
      )
    )
    map

createMap();







