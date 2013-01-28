
sysPath     = require 'path'
compileHBS  = require './ember-handlebars-compiler'
fs          = require 'fs'

module.exports = class EmberHandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'hbs'
  precompile: off
  root: null

  constructor: (@config) ->
    if @config.files.templates.precompile is on
      @precompile = on
    if @config.files.templates.root?
      @root = sysPath.normalize(@config.files.templates.root) + sysPath.sep
      if not fs.existsSync @root
        throw "EmberHandlebarsCompiler: templates.root = #{@root} does not exist";
    null

  compile: (data, path, callback) ->
    try
      name = if @root? then path.replace(@root, '') else path
      if @precompile is on
        content = compileHBS data.toString()
        result  = "\nEmber.TEMPLATES['#{name}'] = Ember.Handlebars.template(#{content});\n module.exports = '#{name}';"
      else
        content = JSON.stringify data.toString()
        result  = "\nEmber.TEMPLATES['#{name}'] = Ember.Handlebars.compile(#{content});\n module.exports = '#{name}';"
    catch err
      error = err
    finally
      callback error, result
