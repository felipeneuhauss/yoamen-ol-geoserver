###*
# Funcao que cria o mapa
###
createMap = ->
  urlJson = undefined

  window.view = new (ol.View)(
    center: [
      -6019652.779802445
      -1708175.0676016365
    ]
    maxZoom: 16
    minZoon: 4
    zoom: 4)

  window.view.on('change:resolution', window.limitZoom)
  window.view.on('change:center', window.limitZoom)

  window.map = new (ol.Map)(
    target: 'map'
    overlays: [window.popup]
    view: window.view)

  window.geoServerLegendLink = 'http://10.1.25.80:10001//geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&layer='
  urlJson = window.location.origin + '/empreendimento.json'
  $.getJSON urlJson, (data) ->
    styles = undefined
    window.enterprises = data
    window.legends = []
    window.elementsProject = []
    window.thematicMaps = []
    styles = window.getStyles()
    window.getBaseMaps()
    window.addElementsProjectLayers data, styles
    window.addThematicMapsLayers styles
    for layer in window.layers
      window.map.addLayer layer

    # Add an event handler for the map "singleclick" event
    window.map.on 'singleclick', (evt) ->
      # Hide existing popup and reset it's offset
      window.popup.setVisible(false)
      window.popup.setOffset [
        0
        0
      ]
      # Attempt to find a marker from the planningAppsLayer
      feature = map.forEachFeatureAtPixel(evt.pixel, (feature, layer) ->
        feature
      )

      console.log(feature)

      if feature
        coord = feature.getGeometry().getCoordinates()
        props = feature.getProperties()
        info = '<h2><a href=\'' + props.caseurl + '\'>' + props.casereference + '</a></h2>'
        info += '<p>' + props.locationtext + '</p>'
        info += '<p>Status: ' + props.status + ' ' + props.statusdesc + '</p>'
        # Offset the popup so it points at the middle of the marker not the tip
        window.popup.setOffset [
          0
          -22
        ]
        window.popup.show coord, info

    map


createMap()
