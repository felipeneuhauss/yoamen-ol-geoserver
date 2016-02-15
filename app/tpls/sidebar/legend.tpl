<table class="table table-striped" id="legends">
    <% _.each(legends, function(legend){ %>
    <tr>
        <td><%= legend.elementName %>
        <img class='pull-right'
         src='http://10.1.25.80:10001/geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=15&HEIGHT=15&layer=<%= legend.element %>'/>
        </td>
    </tr>
    <% }); %>
</table>