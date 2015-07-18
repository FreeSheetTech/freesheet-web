Rx = require 'rx'

sendTextInputs = (freesheet) ->
  isNumeric = (s) -> s and s.match(/^\d*\.?\d+$|^\d+.?\d*$/)
  convertValue = (s)  -> if isNumeric(s) then parseFloat(s) else s

  isTextInputWithName = (event) ->
    el = $(event.target)
    isInput = el.prop('tagName') == 'INPUT' and el.prop('type') == 'text'
    isTextarea = el.prop('tagName') == 'TEXTAREA'
    (isInput or isTextarea) and el.prop('name')

  getSheetAndInputNameWithValue = (event) ->
    inputEl = $(event.target)
    name = inputEl.attr('name')
    [sheetName, inputName] = name.split '.'
    {name, sheetName, inputName, value: convertValue(inputEl.val())}

  allChanges = Rx.Observable.fromEvent($(document), 'change').filter(isTextInputWithName).map(getSheetAndInputNameWithValue)

  allChanges.subscribe ({name, sheetName, inputName, value}) ->
    if not sheetName and inputName then console.warn "Invalid input field name #{name}"; return
    sheet = freesheet.sheets(sheetName)
    if not sheet then console.warn "No sheet with name #{sheetName} for input field #{name}"; return
    if not _.contains(sheet.inputs(), inputName) then console.warn "No input with name #{inputName} in sheet #{sheetName} for input field #{name}"; return
    sheet.input(inputName, value)

sendClicks = (freesheet) ->
  isButtonWithName = (event) ->
    el = $(event.target)
    tag = el.prop('tagName')
    (tag == 'BUTTON' or (tag == 'INPUT' and el.prop('type') == 'button')) and el.prop('name')

  getSheetAndInputName = (event) ->
    inputEl = $(event.target)
    name = inputEl.attr('name')
    [sheetName, inputName] = name.split '.'
    {name, sheetName, inputName}

  allClicks = Rx.Observable.fromEvent($(document), 'click').filter(isButtonWithName).map(getSheetAndInputName)

  allClicks.subscribe ({name, sheetName, inputName}) ->
    if not sheetName and inputName then console.warn "Invalid button name #{name}"; return
    sheet = freesheet.sheets(sheetName)
    if not sheet then console.warn "No sheet with name #{sheetName} for button #{name}"; return
    if not _.contains(sheet.inputs(), inputName) then console.warn "No input with name #{inputName} in sheet #{sheetName} for button #{name}"; return
    sheet.input(inputName, new Date())

attachInputs = (freesheet) ->
  sendTextInputs freesheet
  sendClicks freesheet

pageInputs = {attachInputs}

if typeof module != 'undefined'
  module.exports = pageInputs
else
  window.pageInputs = pageInputs
