## Ember Handlebars for Brunch

This plugin adds [Ember Handlebars](http://emberjs.com/) template pre-compiling to
[brunch](http://brunch.io).

## Usage

Add `"ember-handlebars-brunch": "git+ssh://git@github.com:icholy/ember-handlebars-brunch.git"`. to `package.json` of your brunch app.

set the templates compiler in `config.coffee` set `precompile` to `true` if you want to enable it

    templates:
      precompile: true  # default is false
      root: 'app/templates'
      defaultExtension: 'hbs'
      joinTo: 'javascripts/app.js' : /^app/
      

place your handlebars templates in the `app/templates/` directory and give them a `.hbs` extension

	app/
	  templates/
	    my_template.hbs
      subdir/
        another_template.hbs

then simply `require` them in your views

	App.MyView = Ember.View.extend({
		templateName: 'my_template' // no extension
	});

also accessible through `Ember.TEMPLATES`

    var anotherTemplate = Ember.TEMPLATES['subdir/another_templates']

