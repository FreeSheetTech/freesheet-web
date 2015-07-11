# Top level facade for Freesheet and Freesheet Web

Freesheet = require 'freesheet'
PageFunctions = require './PageFunctions'
TableWorksheet = require '../worksheet/TableWorksheet'

freesheet = new Freesheet()

loadScripts = -> $("script").filter( -> $(this).attr('type') == 'text/freesheet').each (i, el) ->
  scriptEl = $(this)
  sheet = freesheet.createSheet(scriptEl.attr('id'));
  sheet.addFunctions PageFunctions
  sheet.load(scriptEl.text());

createWorksheets = ->
  container = $('.freesheet-worksheets')
  if not container.length then container = $("""<div class="freesheet-worksheets worksheeets-hidden">
                                                   <button class="show-worksheets">Show worksheets</button>
                                                   <button class="hide-worksheets">Hide worksheets</button>
                                                </div>""").appendTo $('body')
  newWorksheet = (sheet) ->
    worksheetEl = $("""<div id="#{sheet.name}_worksheet" class="freesheet-worksheet"></div>""").appendTo container
    new TableWorksheet(worksheetEl, sheet)

  worksheets = (newWorksheet(sheet) for sheet in freesheet.sheets())

  container.on 'click', 'button.show-worksheets', ->
    container.removeClass('worksheeets-hidden')
    sheet.redisplay() for sheet in worksheets

  container.on 'click', 'button.hide-worksheets', -> container.addClass('worksheeets-hidden')

loadScriptsIntoWorksheets = ->
  loadScripts()
  createWorksheets()

freesheetWeb = { loadScripts, createWorksheets, loadScriptsIntoWorksheets }
freesheetWeb[key] = value for key, value of freesheet

if typeof module != 'undefined'
  module.exports = freesheetWeb
else
  window.Freesheet = freesheetWeb
