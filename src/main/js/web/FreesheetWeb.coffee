# Top level facade for Freesheet and Freesheet Web

Freesheet = require 'freesheet'
PageInputs = require './PageInputs'
TableWorksheet = require '../worksheet/TableWorksheet'

freesheet = new Freesheet()
isLogging = false
sheetNo = 0

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
    sheetNo = sheetNo + 1
    sectionEl = $("""<div class="worksheet-section">
                        <div class="worksheet-with-text">
                          <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation"  class="disabled" ><a class="worksheet-name">#{sheet.name}</a></li>
                            <li role="presentation" class="active"><a href="#sheet#{sheetNo}" aria-controls="sheet#{sheetNo}" role="tab" data-toggle="tab">Worksheet</a></li>
                            <li role="presentation"><a href="#text#{sheetNo}" aria-controls="text#{sheetNo}" role="tab" data-toggle="tab">Text</a></li>
                          </ul>
                          <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active worksheet" id="sheet#{sheetNo}"></div>
                            <div role="tabpanel" class="tab-pane" id="text#{sheetNo}"><pre class="text"></pre></div>
                          </div>
                        </div>
                    </div>""").appendTo container
    new TableWorksheet sectionEl.find('.worksheet'), sheet, sectionEl.find('.text')

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
  freesheet.trace !!location.search.match('trace=on')
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
