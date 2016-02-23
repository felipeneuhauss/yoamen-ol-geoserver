/**
 * Funcao de callback chamada antes de cada layer ser criada. A response contem as features vindas do geoserver
 * para ser adicionada a layer.
 */

window.extentMainLayer = null;

window.loadFeatures = (function(response) {
    var lastResponse;
    lastResponse = lastResponse;
    return function(response) {
        lastResponse = response || lastResponse;
        return lastResponse;
    };
})();


/**
 * Obtem os estilos da layers
 * @returns {*}
 */

window.getStyles = function() {
    var response;
    response = void 0;
    response = $.ajax({
        url: '/geo-styles/style.json',
        dataType: 'json',
        async: false,
        success: function(data) {
            return data.responseJSON;
        }
    });
    window.styles = response.responseJSON;
    return response.responseJSON;
};


/**
 * Obtem os mapas base
 * @returns {*[]}
 */

window.getBaseMaps = function() {
    var layersMapa;
    layersMapa = void 0;
    window.baseMaps = [];
    layersMapa = [
        new ol.layer.Tile({
            style: 'Base',
            source: new ol.source.OSM
        }), new ol.layer.Tile({
            style: 'Road',
            source: new ol.source.MapQuest({
                layer: 'osm'
            })
        }), new ol.layer.Tile({
            style: 'Aerial',
            visible: false,
            source: new ol.source.MapQuest({
                layer: 'sat'
            })
        }), new ol.layer.Group({
            style: 'AerialWithLabels',
            visible: false,
            layers: [
                new ol.layer.Tile({
                    source: new ol.source.MapQuest({
                        layer: 'sat'
                    })
                }), new ol.layer.Tile({
                    source: new ol.source.MapQuest({
                        layer: 'hyb'
                    })
                })
            ]
        })
    ];
    window.baseMaps.push({
        id: 'Base',
        name: 'Básico'
    });
    window.baseMaps.push({
        id: 'Road',
        name: 'Estradas'
    });
    window.baseMaps.push({
        id: 'Aerial',
        name: 'Terreno'
    });
    window.baseMaps.push({
        id: 'AerialWithLabels',
        name: 'Terreno com legendas'
    });
    window.layers = layersMapa;
};


/**
 * Add ao projeto as layers das estruturas do projeto como CI_AREA_ESTUDO, CI_CANTEIRO_OBRAS
 */

window.addElementsProjectLayers = function(data, styles) {
    return data.forEach(function(el, index) {
        var structureStyle;
        var geojsonFormat, structureStyle, style, urljson, vector, vectorSource;
        geojsonFormat = void 0;
        structureStyle = void 0;
        style = void 0;
        urljson = void 0;
        vector = void 0;
        vectorSource = void 0;
        urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:' + el.ttTpEstrutura.noTabelaEstrutura + '&maxFeatures=50&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=' + $('#empreendimentoId').val() + '&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857';
        structureStyle = _.find(styles, function(elem) {
            var vectorSource;
            var geojsonFormat;
            return elem.id === el.ttTpEstrutura.noTabelaEstrutura;
        });
        geojsonFormat = new ol.format.GeoJSON;
        vectorSource = new ol.source.Vector({});
        $.ajax({
            url: urljson,
            async: false,
            dataType: 'jsonp',
            jsonCallback: 'parseResponse'
        }).always(function() {
            vectorSource.addFeatures(geojsonFormat.readFeatures(loadFeatures()));
        });

        /**
         * JSONP WFS callback function.
         * @param {Object} response The response object.
         */
        vector = new ol.layer.Vector({
            id: el.ttTpEstrutura.noTabelaEstrutura,
            projectElements: true,
            source: vectorSource,
            style: style = new ol.style.Style({
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
        window.layers.push(vector);
        window.legends.push({
            'element': el.ttTpEstrutura.noTabelaEstrutura,
            'elementName': el.ttTpEstrutura.noTpEstrutura
        });
        return window.elementsProject.push({
            'element': el.ttTpEstrutura.noTabelaEstrutura,
            'elementName': el.ttTpEstrutura.noTpEstrutura,
            'elementInfo': el.ttTpEstrutura.dsInfoEstrutura
        });
    });
};


/**
 *  Funcao que add os mapas tematicos
 */

window.addThematicMapsLayers = function(styles) {
    var i, len, results, structureStyle, styleName, thematicMap, thematicMaps, urljson, wms;
    i = void 0;
    len = void 0;
    results = void 0;
    structureStyle = void 0;
    styleName = void 0;
    thematicMap = void 0;
    thematicMaps = void 0;
    urljson = void 0;
    wms = void 0;
    thematicMaps = [
        {
            id: 'CB_AMAZONIA_LEGAL',
            name: 'Amazônia Legal'
        }, {
            id: 'CB_UNIDADE_CONSERVACAO',
            name: 'Unidade de Conservação'
        }, {
            id: 'CB_HIDROGRAFIA',
            name: 'Hidrografia'
        }, {
            id: 'CB_MASSA_DAGUA',
            name: 'Massa D\'água'
        }, {
            id: 'CB_TERRA_INDIGENA',
            name: 'Terra Indígena'
        }, {
            id: 'CB_UNIDADE_FEDERACAO',
            name: 'Unidade da Federação'
        }, {
            id: 'CB_MUNICIPIO',
            name: 'Município'
        }
    ];
    results = [];
    i = 0;
    len = thematicMaps.length;
    while (i < len) {
        thematicMap = thematicMaps[i];
        urljson = 'http://10.1.25.80:10001/geoserver/siga/ows?service=WFS&version=1.1.0&request=GetFeature&typeName=siga:' + thematicMap.id + '&maxFeatures=50&cql_filter=CD_PROGRESSAO_EMPREENDIMENTO=' + $('#empreendimentoId').val() + '&outputFormat=text/javascript&format_options=callback:loadFeatures&srsname=EPSG:3857';
        styleName = thematicMap.id;
        styleName = styleName.replace('CB_', '');
        structureStyle = _.find(styles, function(elem) {
            return elem.id === styleName;
        });
        wms = new ol.layer.Image({
            id: thematicMap.id,
            thematicMap: true,
            visible: false,
            source: new ol.source.ImageWMS({
                url: 'http://10.1.25.80:10001/geoserver/wms',
                params: {
                    'LAYERS': 'siga:' + thematicMap.id
                },
                serverType: 'geoserver'
            })
        });
        window.layers.push(wms);
        results.push(window.thematicMaps.push({
            'element': thematicMap.id,
            'elementName': thematicMap.name,
            'elementInfo': thematicMap.name
        }));

        if (thematicMap.id == 'CB_HIDROGRAFIA') {
            window.extentMainLayer = wms;
        }

        i++;
    }
    return results;
};

/**
 * Funcao que limita o zoom
 */
window.limitZoom = function() {
    var zoom;
    zoom = window.view.getZoom();
    console.log(zoom < 4 && window.extentMainLayer);
    if (zoom < 4 && window.extentMainLayer) {
        window.view.setZoom(4);
        //window.map.getView().fit(window.extentMainLayer.getSource().getExtent(), window.map.getSize())
    }
};

