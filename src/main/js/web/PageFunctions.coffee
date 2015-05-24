Rx = Freesheet.rx

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
    el.prop('tagName') == 'INPUT' and el.prop('type') == 'text' and el.prop('name')
  changes = Rx.Observable.fromEvent($(document), 'change')
  events = changes.filter((e) -> isTextInputWithName($(e.target))).map(inputValuesFunction).startWith(-> null)
  events


pageFunctions =
  input: makeInputObservable()

  click: (elementId) ->
    el = $("#" + elementId.value)
    Rx.Observable.fromEvent(el, 'click').map((e) -> {time: new Date()})

if typeof module != 'undefined'
  module.exports = pageFunctions
else
  window.PageFunctions = pageFunctions
