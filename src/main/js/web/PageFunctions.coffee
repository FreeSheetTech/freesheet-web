Rx = Freesheet.rx

pageFunctions =
  input: (inputName) ->
    isNumeric = (s) -> s and s.match(/^\d*\.?\d+$|^\d+.?\d*$/)
    convertValue = (s)  -> if isNumeric(s) then parseFloat(s) else s

    inputEl = $("input[name='#{inputName}']")
    Rx.Observable.fromEvent(inputEl, 'change').map((e) -> e.target.value).startWith(inputEl.val()).map(convertValue)

  click: (elementId) ->
    el = $("#" + elementId.value)
    Rx.Observable.fromEvent(el, 'click').map((e) -> {time: new Date()})

if typeof module != 'undefined'
  module.exports = pageFunctions
else
  window.PageFunctions = pageFunctions
