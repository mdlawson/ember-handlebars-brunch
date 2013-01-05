## Ember Handlebars for Brunch

This plugin adds [Ember Handlebars](http://emberjs.com/) template pre-compiling to
[brunch](http://brunch.io).

## Usage

Add `"ember-handlebars-brunch": "git+ssh://git@github.com:icholy/ember-handlebars-brunch.git"`. to `package.json` of your brunch app.

set the templates compiler in `config.coffee` set `precompile` to `true` if you want to enable it

    templates:
      precompile: true  # default is false
      defaultExtension: 'hbs'
      joinTo: 'javascripts/app.js' : /^app/
      

place your handlebars templates in the `app/templates/` directory and give them a `.hbs` extension

	app/
	  templates/
	    my_template.hbs

then simply `require` them in your views

	App.MyView = Ember.View.extend({
		templateName: require('template/my_template') // no extension
	});

## Modifications for Emberjs v2 Router

As of router v2, Emberjs no longer allows you to specify a custom template for your Application View.  [Ember Handlebars Brunch](https://github.com/icholy/ember-handlebars-brunch) used [brunch](http://brunch.io) module IDs to generate the template name.  So application.hbs nested in your directory structure like this...

	app/
		templates/
			application.hbs

would create a Handlebars template called `templates/application`.  This forked project modifies the template pre-compile process by removing `templates/` from every template name.  You still require your templates the same way by using `require('templates/application')`, however, the template will be registered under Em.TEMPLATES as `application`.  This will allow Emberjs with v2 router to work as intended.