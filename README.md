## Ember Handlebars for Brunch

This plugin adds [Ember Handlebars](http://emberjs.com/) template pre-compiling to
[brunch](http://brunch.io).

## Usage

Add `"ember-handlebars-brunch": "x.y.z"` to `package.json` of your brunch app.

Pick a plugin version that corresponds to your minor (y) brunch version.

If you want to use git version of plugin, add
`"ember-handlebars-brunch": "git+ssh://git@github.com:saiwong/ember-handlebars-brunch.git"`.

set the templates compiler in `config.coffee` 

    templates:
      defaultExtension: 'hbs'
      joinTo: 'javascripts/app.js' : /^app/
      

place your handlebars templates in the `app/templates/` directory and give them a `.hbs` extension

	app/
	  templates/
	    my_template.hbs

then simply `require` them in your views

	App.MyView = Ember.View.extend({
		templateName: require('app/template/my_template') // no extension
	});