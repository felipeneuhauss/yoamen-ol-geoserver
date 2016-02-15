setBaseMap = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)

    $('.toggle-basemap').click ()->
      console.log(window.layers)
      selectedStyleName = id = $(@).attr('id')

      for layer in window.layers
        styleLayerName = layer.get('style')
        if (['Road', 'Aerial', 'AerialWithLabels'].indexOf(styleLayerName) >= 0)
          console.log(layer, styleLayerName, styleLayerName == selectedStyleName)
          layer.set('visible', styleLayerName == selectedStyleName)


    clearInterval(setBaseMap)
  return
), 100)
