compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
console.log(compiled)
$('#project-elements').html(compiled(name:'Felipe'))