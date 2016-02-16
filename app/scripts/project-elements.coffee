setElementsProject = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)
    $('[data-toggle="popover"]').popover()

    # Centraliza o mapa na estrutura principal que e a area de estudo
    $('.extent').click(()->
      layer = _.find window.layers, (layer) ->
        layer.get('id') == 'CI_AREA_ESTUDO'

      console.log(layer.get('id'))
      # Centraliza o mapa na estrutura
      window.map.getView().fit(layer.getSource().getExtent(), window.map.getSize())
    )

    clearInterval(setElementsProject)
  return
), 100)
