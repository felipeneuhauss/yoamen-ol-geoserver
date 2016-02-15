console.log '\'Allo \'Allo!'
console.log 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siga:CI_CANTEIRO_OBRA&outputFormat=text/javascript&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=9816'
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



###*
# Helper method for map-creation.
#
# @param {string} divId The id of the div for the map.
# @return {ol.Map} The ol.Map instance.
###

createMap = () ->

  urlJson = window.location.origin+'/empreendimento.json'

  $.getJSON urlJson, (data) ->

    window.enterprises = data

    baseLayer = new ol.layer.Tile({source: new ol.source.OSM()})

    layers = [];

    styles = getStyles()

    # Mapa base
    layers.push(baseLayer)

    window.legends = []
    # Para cada estrutura vai ao geoserver pega as features
    data.forEach((el, index)->

      console.log(el)
      #if el.ttTpEstrutura.noTabelaEstrutura == 'CI_CANTEIRO_OBRA'
      console.log(el.ttTpEstrutura.noTabelaEstrutura);
      urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:'+ el.ttTpEstrutura.noTabelaEstrutura+'&maxFeatures=50&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO='+$('#empreendimentoId').val()+'&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857'
      console.log(urljson)

      structureStyle = _.find styles, (elem) ->
        elem.id == el.ttTpEstrutura.noTabelaEstrutura


      console.log(structureStyle, el.ttTpEstrutura.noTabelaEstrutura)

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
        console.log(response)
        vectorSource.addFeatures geojsonFormat.readFeatures(response)
        return

      # {"id": "CI_AREA_ESTUDO", "stroke": "#FF0000", "strokeWidth": 1.5, "fill": "transparent"},
      console.log(structureStyle)
      vector = new (ol.layer.Vector)(
        source: vectorSource
        style: new (ol.style.Style)(
          fill: new (ol.style.Fill)(
            color: if !_.isUndefined(structureStyle.fill) then structureStyle.fill else null
            opacity: if !_.isUndefined(structureStyle.fillOpacity) then structureStyle.fillOpacity else null)
          stroke: new (ol.style.Stroke)(
            color: if !_.isUndefined(structureStyle.stroke) then structureStyle.stroke else null
            width: if !_.isUndefined(structureStyle.strokeWidth) then structureStyle.strokeWidth else 0)))

      layers.push(vector)
      window.geoServerLegendLink = "http://10.1.25.80:10001//geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&layer="
      window.legends.push("element":el.ttTpEstrutura.noTabelaEstrutura, "elementName": el.ttTpEstrutura.noTpEstrutura)

    )

    # Cria o mapa com as layers
    window.map = new ol.Map(
      layers: layers,
      target: 'map',
      view: new ol.View(
        center: [-6019652.779802445, -1708175.0676016365],
        zoom: 4
      )
    )
    map

createMap();



