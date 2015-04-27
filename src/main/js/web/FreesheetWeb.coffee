# Top level facade for Freesheet and Freesheet Web

Freesheet = require 'freesheet'

freesheetWeb = {
  loadScripts: -> $("script").filter( -> $(this).attr('type') == 'text/freesheet').each (i, el) ->
    scriptEl = $(this)
    sheet = Freesheet.createSheet(scriptEl.attr('id'));
    sheet.load(scriptEl.text());
}

freesheetWeb[key] = value for key, value of Freesheet

if typeof module != 'undefined'
  module.exports = freesheetWeb
else
  window.Freesheet = freesheetWeb
