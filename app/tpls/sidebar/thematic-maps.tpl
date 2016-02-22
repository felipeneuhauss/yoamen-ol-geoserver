<table class="table table-hover">
    <tr>
        <td>
            <input type='radio' class="toggle-thematic-map" name="thematic-map"
                   id="none">
            &nbsp;
            <label for="none">Nenhum</label>
            <a href="#" class="btn btn-default pull-right" style="margin-right:10px;">
                <img class='pull-right' height="20px" width="20px"/>
            </a>
        </td>
    </tr>
	<% _.each(thematicMaps, function(element){ %>
	<tr>
        <td>
            <input type='radio' class="toggle-thematic-map" name="thematic-map"
                   id="<%= element.element %>">
            &nbsp;
            <label for="<%= element.element %>">
            <%=element.elementName %>
            </label>
            <a href="#" class="btn btn-default pull-right" style="margin-right:10px;">
                <img class='pull-right'
                     src='http://10.1.25.80:10001/geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&layer=<%= element.element %>'/>
            </a>
		</td>
	</tr>
	<% }); %>
</table>
