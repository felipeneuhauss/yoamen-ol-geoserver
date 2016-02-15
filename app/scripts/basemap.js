// Generated by CoffeeScript 1.10.0
(function() {
  var setBaseMap;

  setBaseMap = setInterval((function() {
    if (!_.isUndefined(window.legends) && !_.isUndefined(window.elementsProject)) {
      $('.toggle-basemap').click(function() {
        var i, id, layer, len, ref, results, selectedStyleName, styleLayerName;
        console.log(window.layers);
        selectedStyleName = id = $(this).attr('id');
        ref = window.layers;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          layer = ref[i];
          styleLayerName = layer.get('style');
          if (['Road', 'Aerial', 'AerialWithLabels'].indexOf(styleLayerName) >= 0) {
            console.log(layer, styleLayerName, styleLayerName === selectedStyleName);
            results.push(layer.set('visible', styleLayerName === selectedStyleName));
          } else {
            results.push(void 0);
          }
        }
        return results;
      });
      clearInterval(setBaseMap);
    }
  }), 100);

}).call(this);

//# sourceMappingURL=basemap.js.map
