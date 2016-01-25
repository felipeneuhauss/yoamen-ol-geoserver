console.log '\'Allo \'Allo!'
console.log 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siga:CI_CANTEIRO_OBRA&outputFormat=text/javascript&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=9816'
# eslint-disable-line no-console


window.loadFeatures = (response) ->
  vectorSource.addFeatures geojsonFormat.readFeatures(response)
  return

###*
# Helper method for map-creation.
#
# @param {string} divId The id of the div for the map.
# @return {ol.Map} The ol.Map instance.
###

createMap = (divId) ->


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

  geojsonFormat = new ol.format.GeoJSON();

  vectorSource = new (ol.source.Vector)(
    loader: (extent, resolution, projection) ->
      urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:CB_DIVISAO_HIDROGRAFICA&maxFeatures=9999&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857'
      # use jsonp: false to prevent jQuery from adding the "callback"
      # parameter to the URL
      $.ajax
        url: urljson
        dataType: 'jsonp'
        jsonCallback: 'parseResponse'
      return
    projection: 'EPSG:3857'
    strategy: new ol.loadingstrategy.tile(ol.tilegrid.createXYZ(maxZoom: 19)))


  vector = new ol.layer.Vector(
    source: vectorSource,
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

