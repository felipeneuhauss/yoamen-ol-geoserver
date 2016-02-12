console.log(window.enterprises);
compiled = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/project-elements.tpl'))
$('#project-elements').html(compiled(enterprises:window.enterprises))

compiledHelp = _.template(CoreView.template(BASE_URL+'/tpls/sidebar/help.tpl'))
$('#help').html(compiledHelp())

