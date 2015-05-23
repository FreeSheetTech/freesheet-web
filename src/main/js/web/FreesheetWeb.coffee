# Top level facade for Freesheet and Freesheet Web

Freesheet = require 'freesheet'

freesheetWeb = {
  loadScripts: -> $("script").filter( -> $(this).attr('type') == 'text/freesheet').each (i, el) ->
    scriptEl = $(this)
    sheet = Freesheet.createSheet(scriptEl.attr('id'));
    sheet.addFunctions PageFunctions
    sheet.load(scriptEl.text());

  createWorksheets: ->
    container = $('.freesheet-worksheets')
    for sheet in Freesheet.sheets()
      worksheetEl = $("<div id='#{sheet.name}_worksheet'></div>").appendTo container
      new TableWorksheet(worksheetEl, sheet)

}

freesheetWeb[key] = value for key, value of Freesheet

if typeof module != 'undefined'
  module.exports = freesheetWeb
else
  window.Freesheet = freesheetWeb
