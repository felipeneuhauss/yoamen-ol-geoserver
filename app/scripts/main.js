// Generated by CoffeeScript 1.10.0
(function() {
  var createMap, getStyles;

  console.log('\'Allo \'Allo!');

  console.log('http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=siga:CI_CANTEIRO_OBRA&outputFormat=text/javascript&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=9816');

  window.loadFeatures = function(response) {
    vectorSource.addFeatures(geojsonFormat.readFeatures(response));
  };

  getStyles = function() {
    var response;
    response = $.ajax({
      url: '/geo-styles/style.json',
      dataType: 'json',
      async: false,
      success: function(data) {
        return data.responseJSON;
      }
    });
    return response.responseJSON;
  };


  /**
   * Helper method for map-creation.
   *
   * @param {string} divId The id of the div for the map.
   * @return {ol.Map} The ol.Map instance.
   */

  createMap = function() {
    var urlJson;
    urlJson = window.location.origin + '/empreendimento.json';
    return $.getJSON(urlJson, function(data) {
      var baseLayer, layers, styles, infoTag, subtitle;
      window.enterprises = data;
      baseLayer = new ol.layer.Tile({
        source: new ol.source.OSM()
      });
      layers = [];
      styles = getStyles();
      infoTag = [];
      subtitle = document.getElementById("subtitle");
      layers.push(baseLayer);

      data.forEach(function(el, index) {
        var geojsonFormat, structureStyle, urljson, vector, vectorSource;
        console.log(el.ttTpEstrutura.noTabelaEstrutura);
        urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:' + el.ttTpEstrutura.noTabelaEstrutura + '&maxFeatures=50&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=' + $('#empreendimentoId').val() + '&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857';
        console.log(urljson);
        structureStyle = _.find(styles, function(elem) {
          return elem.id === el.ttTpEstrutura.noTabelaEstrutura;
        });
        console.log(structureStyle, el.ttTpEstrutura.noTabelaEstrutura);
        geojsonFormat = new ol.format.GeoJSON;
        vectorSource = new ol.source.Vector({
          loader: function(extent, resolution, projection) {
            $.ajax({
              url: urljson,
              dataType: 'jsonp',
              jsonCallback: 'parseResponse'
            });
          }
        });

        /**
         * JSONP WFS callback function.
         * @param {Object} response The response object.
         */

        window.loadFeatures = function(response) {
         console.log(response);
          vectorSource.addFeatures(geojsonFormat.readFeatures(response));
        };
        console.log(structureStyle);
        vector = new ol.layer.Vector({
          source: vectorSource,
          style: new ol.style.Style({
            fill: new ol.style.Fill({
              color: !_.isUndefined(structureStyle.fill) ? structureStyle.fill : null,
              opacity: !_.isUndefined(structureStyle.fillOpacity) ? structureStyle.fillOpacity : null
            }),
            stroke: new ol.style.Stroke({
              color: !_.isUndefined(structureStyle.stroke) ? structureStyle.stroke : null,
              width: !_.isUndefined(structureStyle.strokeWidth) ? structureStyle.strokeWidth : 0
            })
          })
        });
        return layers.push(vector), 
                infoTag.push("<tr><td>"+el.ttTpEstrutura.noTpEstrutura+"<img class='pull-right' src='http://10.1.25.80:10001//"+
                 "geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&layer="+
                 el.ttTpEstrutura.noTabelaEstrutura+"'/></td></tr>")
      });
      
      subtitle.innerHTML = infoTag;
      subtitle.removeChild(subtitle.lastChild);

      window.map = new ol.Map({
        layers: layers,
        target: 'map',
        view: new ol.View({
          center: [-6019652.779802445, -1708175.0676016365],
          zoom: 4
        })
      });
      return map;
    });
  };

  createMap();

}).call(this);

//# sourceMappingURL=main.js.map
