setElementsProject = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)
    $('[data-toggle="popover"]').popover()

    # Centraliza o mapa na estrutura principal que e a area de estudo
    $('.extent').click(()->
      layer = _.find window.layers, (layer) ->
        console.log(layer.get(id))
        layer.get('id') == 'CI_AREA_ESTUDO'

      window.map.getView().fit(layer.getSource().getExtent(), window.map.getSize())
    )

    $('.toggle-element').click(()->
      id = $(@).attr('id')
      console.log(id)
      checked = $(@).is(':checked')
      for layer in window.layers
        if (!_.isUndefined(layer.get('projectElements')))
          if (id == layer.get('id'))
            layer.set('visible',  checked)
    )

    clearInterval(setElementsProject)
  return
), 100)
