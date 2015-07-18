# Top level facade for Freesheet and Freesheet Web

Freesheet = require 'freesheet'
PageInputs = require './PageInputs'
TableWorksheet = require '../worksheet/TableWorksheet'

freesheet = new Freesheet()
isLogging = false

sheets = (name) -> freesheet.sheets(name)
createSheet = (name) -> freesheet.createSheet(name)
destroy = -> freesheet.destroy()


loadScripts = -> $("script").filter( -> $(this).attr('type') == 'text/freesheet').each (i, el) ->
  scriptEl = $(this)
  sheet = createSheet(scriptEl.attr('data-name'));
  sheet.load(scriptEl.text());

createWorksheets = ->
  container = $('.freesheet-worksheets')
  if not container.length then container = $("""<div class="freesheet-worksheets worksheeets-hidden">
                                                   <button class="show-worksheets">Show worksheets</button>
                                                   <button class="hide-worksheets">Hide worksheets</button>
                                                </div>""").appendTo $('body')
  newWorksheet = (sheet) ->
    sectionEl = $("""<div class="worksheet-section">
                        <div class="worksheet-name">#{sheet.name}</div>
                        <div class="worksheet"></div>
                    </div>""").appendTo container
    worksheetId = sheet.name.replace /\s/g, '_'
    worksheetEl = $("""<div id="#{worksheetId}_worksheet" class="freesheet-worksheet"></div>""").appendTo sectionEl
    new TableWorksheet(worksheetEl, sheet)

  logWorksheetChanges = (sheet) ->
    sheet.onValueChange (name, value) -> if isLogging then console.log "[#{sheet.name}] #{name} = ", value

  worksheets = (newWorksheet(sheet) for sheet in sheets())

  container.on 'click', 'button.show-worksheets', ->
    container.removeClass('worksheeets-hidden')
    sheet.redisplay() for sheet in worksheets

  container.on 'click', 'button.hide-worksheets', -> container.addClass('worksheeets-hidden')

  logWorksheetChanges sheet for sheet in sheets()

attachInputs =  -> PageInputs.attachInputs(freesheet)

initPage = ->
  loadScripts()
  createWorksheets()
  PageInputs.attachInputs(freesheet)
  PageInputs.linkSheetsWithInputSources(freesheet)

logChanges = (onOff = true) -> isLogging = onOff

freesheetWeb = { loadScripts, createWorksheets, attachInputs, initPage, logChanges, sheets, createSheet, destroy }

if typeof module != 'undefined'
  module.exports = freesheetWeb
  window.Freesheet = freesheetWeb
else
  window.Freesheet = freesheetWeb
