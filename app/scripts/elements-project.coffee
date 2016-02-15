setElementsProject = setInterval((->
  if !_.isUndefined(window.legends) and !_.isUndefined(window.elementsProject)
    $('[data-toggle="popover"]').popover()
    clearInterval(setElementsProject)
  return
), 100)
