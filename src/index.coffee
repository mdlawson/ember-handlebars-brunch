
sysPath     = require 'path'
compileHBS  = require './ember-handlebars-compiler'

module.exports = class EmberHandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'hbs'
  precompile: off

  constructor: (@config) ->
    if @config.files.templates.precompile is on
      @precompile = on
    null

  compile: (data, path, callback) ->
    try
      if @precompile is on
        content = compileHBS data.toString()
        result = "\nvar templateName = module.id.replace('templates/', '');\n" +
                 "Ember.TEMPLATES[templateName] = Ember.Handlebars.template(#{content});\n" +
                 "module.exports = templateName;"
      else
        content = JSON.stringify data.toString()
        result = "\nvar templateName = module.id.replace('templates/', '');\n" +
                 "Ember.TEMPLATES[templateName] = Ember.Handlebars.compile(#{content});\n" +
                 "module.exports = templateName;"
    catch err
      error = err
    finally
      callback error, result
