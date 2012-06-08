
sysPath     = require 'path'
compileHBS  = require './ember-handlebars-compiler'

module.exports = class EmberHandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'hbs'

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      content = compileHBS JSON.stringify(data.toString())
      result = "Ember.TEMPLATES[module.id] = #{content}; module.exports = module.id;"
    catch err
      error = err
    finally
      callback error, result

  include: [
    sysPath.join __dirname, '..', 'vendor', 'handlebars-1.0.0.beta.6.js'
    sysPath.join __dirname, '..', 'vendor', 'ember.js'
  ]
