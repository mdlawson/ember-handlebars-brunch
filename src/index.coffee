
sysPath     = require 'path'
fs          = require 'fs'
compileHBS  = require './ember-handlebars-compiler'
jade        = require 'jade'

module.exports = class EmberHandlebarsCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'hbs'
  precompile: off
  jade: true
  root: null
  modulesPrefix: ''

  constructor: (@config) ->
    if @config.files.templates.precompile is on
      @precompile = on
	if @config.files.templates.jade is true
	  @jade = true
    if @config.files.templates.root?
      @root = sysPath.join 'app', @config.files.templates.root, sysPath.sep
    if @config.modules.wrapper is on
      @modulesPrefix = 'module.exports = '
    null

  compile: (data, path, callback) ->
    try
      tmplPath = path.replace @root, ''
      tmplPath = tmplPath.substr 0, tmplPath.length - sysPath.extname(tmplPath).length
      tmplName = "Ember.TEMPLATES['#{tmplPath}']"
	  
	  handlebars = data.toString()
	  if @jade is true
		handlebars = jade.compile(handlebars,{filename:path})()
      if @precompile is on
        content = compileHBS handlebars
      else
        content = JSON.stringify handlebars
      result = "#{@modulesPrefix}#{tmplName} = Ember.Handlebars.compile(#{content});"
    catch err
      error = err
    finally
      callback error, result
