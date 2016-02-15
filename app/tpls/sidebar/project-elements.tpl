<div class="form-group">
<button class="btn btn-default pull-right"> <i class="fa fa-arrows-alt"></i> </button>
<p align="justify">Para enquadrar ou visualizar uma das feições declaradas, selecione um ou mais elementos do projeto e clique no botão <b>ENQUADRAR</b> exibido acima</p>
<p><input type="checkbox"/> <b>Selecionar todos</b></p>

<table class="table table-striped" id="legends">
	<% _.each(elementsProject, function(element){ %>
	<tr>
		<td>
		<input type='checkbox' class="toggle-element" id="<%= element.element %>"> <%=element.elementName %>
		<button type='button' class='btn btn-default pull-right' data-container='body' data-toggle='popover' data-placement='left' data-content='<%=element.elementInfo%>'>
		  	<i class='fa fa-info'></i>
		</button>
		</td>
	</tr>
		
	<% }); %>
</table>
<script>
	$('[data-toggle="popover"]').popover();
</script>
</div>
