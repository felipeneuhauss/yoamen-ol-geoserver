/**
 * Created by felipeneuhauss on 22/02/16.
 */
/**
 * Elements that make up the popup.
 */
var container = document.getElementById('popup');
window.popupContent = document.getElementById('popup-content');
var closer = document.getElementById('popup-closer');


/**
 * Add a click handler to hide the popup.
 * @return {boolean} Don't follow the href.
 */
closer.onclick = function() {
    window.popup.setVisible(false);
    closer.blur();
    return false;
};

/**
 * Create an overlay to anchor the popup to the map.
 */
window.popup = new ol.Overlay(/** @type {olx.OverlayOptions} */ ({
    element: container,
    autoPan: true,
    autoPanAnimation: {
        duration: 250
    }
}));