setThematicMap = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)
    $('.toggle-thematic-map').click(()->
      layer = _.find window.layers, (layer) ->
        if layer.get('id') == $(@).attr('id')
          return true
        else
          layer.setVisible false

      layer.setVisible(true)

      window.map.removeLayer(layer)
      window.map.addLayer(layer)
    )

    clearInterval(setThematicMap)
  return
), 100)
