setThematicMap = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)
    $('.toggle-thematic-map').click(()->
      id = $(@).attr('id')
      for layer in window.layers
        if (!_.isUndefined(layer.get('thematicMap')))
          layer.set('visible', id == layer.get('id'))
    )

    clearInterval(setThematicMap)
  return
), 100)
