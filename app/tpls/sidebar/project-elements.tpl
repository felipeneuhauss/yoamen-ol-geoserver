<div class="form-group">
<p align="justify">Para enquadrar ou visualizar uma das feições declaradas, selecione um ou
    mais elementos do projeto e clique no botão.</p>
<p><a href="#" class="btn btn-default extent"><i class="fa fa-arrows-alt"></i> Enquadrar</a></p>
<!--<p><input type="checkbox" class="checked-all" checked="checked" /> <b>Selecionar todos</b></p> -->

<table class="table table-hover">
	<% _.each(elementsProject, function(element){ %>
	<tr>
        <td>
            <input type='checkbox' class="toggle-element" checked="checked"
                   id="<%= element.element %>">
            &nbsp;
            <%=element.elementName %>
        </td>
		<td>
            <button type='button' class='btn btn-default pull-right' data-container='body'
                    data-toggle='popover' data-trigger='hover' data-placement='left'
                    data-content='<%=element.elementInfo%>'>
                <i class='fa fa-info'></i>
            </button>

            <a href="#" class="btn btn-default pull-right" style="margin-right:10px;">
                <img class='pull-right'
                     src='http://10.1.25.80:10001/geoserver/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&layer=<%= element.element %>'/>
            </a>

		</td>
	</tr>
	<% }); %>
</table>
</div>
