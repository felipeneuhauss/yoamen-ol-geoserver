compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
console.log('map',window.map);
$('#project-elements').html(compiled(name:'Felipe'))
