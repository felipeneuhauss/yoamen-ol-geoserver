<div class="form-group">
    <table class="table table-hover" id="base-maps-table">
        <% _.each(baseMaps, function(baseMap){ %>
        <tr>
            <td>
                <input type="radio" name="base-maps" class="toggle-basemap" id="<%= baseMap.id %>">

                <%=baseMap.name %>
            </td>
        </tr>
        <% }); %>
    </table>
</div>
