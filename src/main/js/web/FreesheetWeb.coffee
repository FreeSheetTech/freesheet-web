# Top level facade for Freesheet and Freesheet Web

Freesheet = require 'freesheet'
PageFunctions = require './PageFunctions'
TableWorksheet = require '../worksheet/TableWorksheet'

loadScripts = -> $("script").filter( -> $(this).attr('type') == 'text/freesheet').each (i, el) ->
  scriptEl = $(this)
  sheet = Freesheet.createSheet(scriptEl.attr('id'));
  sheet.addFunctions PageFunctions
  sheet.load(scriptEl.text());

createWorksheets = ->
  container = $('.freesheet-worksheets')
  if not container.length then container = $("""<div class="freesheet-worksheets hidden">
                                                   <button class="show">Show worksheets</button>
                                                   <button class="hide">Hide worksheets</button>
                                                </div>""").appendTo $('body')
  for sheet in Freesheet.sheets()
    worksheetEl = $("""<div id="#{sheet.name}_worksheet" class="freesheet-worksheet"></div>""").appendTo container
    new TableWorksheet(worksheetEl, sheet)
  container.on 'click', 'button.show', -> container.removeClass('hidden')
  container.on 'click', 'button.hide', -> container.addClass('hidden')

loadScriptsIntoWorksheets = ->
  loadScripts()
  createWorksheets()

freesheetWeb = { loadScripts, createWorksheets, loadScriptsIntoWorksheets }
freesheetWeb[key] = value for key, value of Freesheet

if typeof module != 'undefined'
  module.exports = freesheetWeb
else
  window.Freesheet = freesheetWeb
