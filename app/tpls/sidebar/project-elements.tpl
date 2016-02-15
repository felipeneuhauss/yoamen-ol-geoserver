<div class="form-group">
<p align="justify">Para enquadrar ou visualizar uma das feições declaradas, selecione um ou mais elementos do projeto e clique no botão <b>ENQUADRAR</b> exibido acima</p>
<p><input type="checkbox"/> Selecionar todos</p>

<table class="table table-striped" id="legends">
	<% _.each(elementProject, function(element){ %>
		<input type='checkbox'><% elemnt.elementName %>
		<button type='button' class='btn btn-default pull-right'
		  data-container='body' data-toggle='popover' data-placement='left' data-content='element.elementInfo'>
		  	<i class='fa fa-info'></i>
		</button>
	<% }); %>
</table>
</div>
