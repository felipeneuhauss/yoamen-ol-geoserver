compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
console.log('')
$('#project-elements').html(compiled(name:'Felipe'))

compiledHelp = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/help.tpl'))
console.log(compiledHelp())
$('#help').html(compiledHelp())