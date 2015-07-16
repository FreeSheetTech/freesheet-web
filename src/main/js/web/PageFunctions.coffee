Rx = require 'rx'

streamReturn = (fn) -> fn.returnKind = 'streamReturn'; fn

makeInputObservable = ->
  isNumeric = (s) -> s and s.match(/^\d*\.?\d+$|^\d+.?\d*$/)
  convertValue = (s)  -> if isNumeric(s) then parseFloat(s) else s

  inputValues = {}
  inputValuesFunction = (e) ->
    inputEl = $(e.target)
    inputValues[inputEl.attr('name')] = convertValue(inputEl.val())
    copyValues = $.extend({}, inputValues)
    (name) -> copyValues[name]

  isTextInputWithName = (el) ->
    isInput = el.prop('tagName') == 'INPUT' and el.prop('type') == 'text'
    isTextarea = el.prop('tagName') == 'TEXTAREA'
    (isInput or isTextarea) and el.prop('name')

  changes = Rx.Observable.fromEvent($(document), 'change')
  events = changes.filter((e) -> isTextInputWithName($(e.target))).map(inputValuesFunction).startWith(-> null)
  events

makeClickObservable = ->
  clicks = {}
  clicksFunction = (e) ->
    buttonEl = $(e.target)
    clicks[buttonEl.attr('name')] = new Date()
    copy = $.extend({}, clicks)
    (name) -> copy[name]

  isButtonWithName = (el) ->
    tag = el.prop('tagName')
    (tag == 'BUTTON' or (tag == 'INPUT' and el.prop('type') == 'button')) and el.prop('name')

  changes = Rx.Observable.fromEvent($(document), 'click')
  events = changes.filter((e) -> isButtonWithName($(e.target))).map(clicksFunction).startWith(-> null)
  events

makeClick = ->
  isButtonWithName = (event) ->
    el = $(event.target)
    tag = el.prop('tagName')
    (tag == 'BUTTON' or (tag == 'INPUT' and el.prop('type') == 'button')) and el.prop('name')

  allClicks = Rx.Observable.fromEvent($(document), 'click').filter(isButtonWithName).map (e) -> {name: $(e.target).attr('name'), time: new Date()}
  fn = (name) -> allClicks.filter((c) -> c.name == name).map (c) -> c.time
  streamReturn fn

localStore = (s, storeName) ->
  key = "freesheet.#{storeName}"
  itemsInStore = -> JSON.parse(window.localStorage.getItem(key)) or []
  appendToStore = (x) ->
    updatedItems = itemsInStore().concat x
    window.localStorage.setItem key, JSON.stringify updatedItems

  s.do(appendToStore).startWith(itemsInStore()...)


pageFunctions =
  inputFrom: makeInputObservable()
  clickOld: makeClickObservable()
  click: makeClick()
  localStore: localStore

if typeof module != 'undefined'
  module.exports = pageFunctions
else
  window.PageFunctions = pageFunctions
