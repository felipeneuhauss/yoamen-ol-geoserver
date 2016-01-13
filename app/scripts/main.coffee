console.log '\'Allo \'Allo!'
console.log 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siga:CI_CANTEIRO_OBRA&outputFormat=application/json&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=9816'
# eslint-disable-line no-console

###*
# Helper method for map-creation.
#
# @param {string} divId The id of the div for the map.
# @return {ol.Map} The ol.Map instance.
###

createMap = (divId) ->

  $.get('http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siga:CI_CANTEIRO_OBRA&outputFormat=application/json&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=9816', (result)->
    console.log(result)
  )

  baseMapLayer = new ol.layer.Tile
    source: new ol.source.OSM()

  style = new ol.style.Style(
    fill: new ol.style.Fill(
      color: '#FF0000'
    ),
    stroke: new ol.style.Stroke(
      color: '#319FD3'
      width: 1
    )
  )

  vector = new ol.layer.Vector(
    source: new ol.source.Vector(
      url: BASE_URL+'/geojson/geojson.json',
      format: new ol.format.GeoJSON()
    ),
    style: style
  )

  map = new ol.Map(
    layers: [baseMapLayer, vector],
    target: divId,
    view: new ol.View(
      center: [-6019652.779802445, -1708175.0676016365],
      zoom: 4
    )
  )
  map

map2 = createMap('map')

