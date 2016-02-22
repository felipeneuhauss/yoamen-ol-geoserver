///**
// * Created by felipeneuhauss on 13/01/16.
// */
//// format used to parse WFS GetFeature responses
//var geojsonFormat = new ol.format.GeoJSON();
//
//var vectorSource = new ol.source.Vector({
//    loader: function(extent, resolution, projection) {
//        var urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&' +
//            'request=GetFeature&typeName=siga:CB_DIVISAO_HIDROGRAFICA&maxFeatures=9999&' +
//            'outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857&bbox=' + extent.join(',')';
//        // use jsonp: false to prevent jQuery from adding the "callback"
//        // parameter to the URL
//
//
//        $.ajax({
//            url :urljson,
//            dataType: 'jsonp',
//            jsonCallback:'parseResponse'
//        });
//    },
//    strategy: ol.loadingstrategy.tile(ol.tilegrid.createXYZ({
//        maxZoom: 19
//    }))
//});
//
//
///**
// * JSONP WFS callback function.
// * @param {Object} response The response object.
// */
//window.loadFeatures = function(response) {
//    vectorSource.addFeatures(geojsonFormat.readFeatures(response));
//};
//
//var vector = new ol.layer.Vector({
//    source: vectorSource,
//    style: new ol.style.Style({
//        stroke: new ol.style.Stroke({
//            color: 'rgba(0, 0, 255, 1.0)',
//            width: 2
//        })
//    })
//});
//
//
//var map = new ol.Map({
//    layers: [new ol.layer.Tile({source: new ol.source.OSM()}), vector],
//    target: document.getElementById('map'),
//    view: new ol.View({
//        center: [-33, -33],
//        maxZoom: 19,
//        zoom: 10
//    })
//});
