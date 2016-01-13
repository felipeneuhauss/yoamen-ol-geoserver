compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
$('#project-elements').html(compiled(name:'Felipe'))