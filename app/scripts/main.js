// Generated by CoffeeScript 1.10.0

/**
 * Funcao que cria o mapa
 */

(function() {
  var createMap;

  createMap = function() {
    var urlJson;
    urlJson = void 0;
    window.view = new ol.View({
      center: [-6019652.779802445, -1708175.0676016365],
      maxZoom: 16,
      minZoon: 4,
      zoom: 4
    });
    window.view.on('change:resolution', window.limitZoom);
    window.view.on('change:center', window.limitZoom);
    window.map = new ol.Map({
      target: 'map',
      overlays: [window.popup],
      view: window.view
    });
    window.geoServerLegendLink = 'http://10.1.25.80:10001//geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&layer=';
    urlJson = window.location.origin + '/empreendimento.json';
    return $.getJSON(urlJson, function(data) {
      var i, layer, len, ref, styles;
      styles = void 0;
      window.enterprises = data;
      window.legends = [];
      window.elementsProject = [];
      window.thematicMaps = [];
      styles = window.getStyles();
      window.getBaseMaps();
      window.addElementsProjectLayers(data, styles);
      window.addThematicMapsLayers(styles);
      ref = window.layers;
      for (i = 0, len = ref.length; i < len; i++) {
        layer = ref[i];
        window.map.addLayer(layer);
      }
      window.map.on('singleclick', function(evt) {
        var feature, info, props;
        window.popup.setVisible(false);
        window.popup.setOffset([0, 0]);
        console.log(evt.pixel, evt);
        feature = window.map.forEachFeatureAtPixel(evt.pixel, function(feature, layer) {
            console.log(feature, layer);
          return feature;
        });
        console.log(feature);
        if (feature) {
          props = feature.getProperties();
            console.log(prop);
          window.popupContent = info;
          window.popup.setVisible(true);
          window.popup.setPosition(evt.coordinate);
        } else {
            window.popup.setVisible(false);
        }
      });
      return map;
    });
  };

  createMap();

}).call(this);
