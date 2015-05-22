# Reactive Template functions for use with Freesheet

eachTableBody = (html, eachExpr) ->
  re = /<tbody>([\s\S]+)<\/tbody>/m
  eachStartTag = "{{#each " + eachExpr + "}}"
  replacement = "<tbody>" + eachStartTag + "$1" + "{{/each}}" + "</tbody>"
  html.replace re, replacement


eachListBody = (html, eachExpr) ->
  re = /(<ul.*?>|<ol.*?>)([\s\S]+)(<\/ul>|<\/ol>)/m
  eachStartTag = "{{#each " + eachExpr + "}}"
  replacement = "$1" + eachStartTag + "$2" + "{{/each}}" + "$3"
  html.replace re, replacement


makeEach = (match, eachExpr, body) ->
  bodyEl = $(body)
  switch
    when bodyEl.length > 1 then body
    when bodyEl.filter('table').length == 1 then eachTableBody(body, eachExpr)
    when bodyEl.filter('ul,ol').length == 1 then eachListBody(body, eachExpr)
    else body

preProcessTags = (html) ->
  re = /\{\{#eachInside (.+)\}\}([\s\S]+?)\{\{\/eachInside\}\}/gm
  html.replace re, makeEach


attachSheet = (template, sheet) ->

  attachFormula = (name, value) ->
    sheetData.set name, value
    sheetData[name] = -> sheetData.get name
    sheet.onChange (n, v) -> sheetData.set n, v

  sheetData = new ReactiveDict()
  attachFormula(fav.name, fav.value) for fav in sheet.formulasAndValues()

  helpers = {}
  helpers[sheet.name] = -> sheetData
  template.helpers helpers

reactiveTemplate = {

  makeTemplate: (elOrSel) ->
    templateHtml = $('#template').html()
    preProcessedHtml = preProcessTags templateHtml
#    console.log "templateHtml", preProcessedHtml
    renderer = eval(SpacebarsCompiler.compile(preProcessedHtml, {isTemplate: true}))
    template = UI.Template renderer
    attachSheet template, sheet for sheet in Freesheet.sheets()
    template


  renderTemplate: (template, containerElOrSel) ->
    parentNode = $(containerElOrSel).get(0)
    Blaze.render(template, parentNode)

  convertToTemplate: (elOrSel) ->
    el = $(elOrSel)
    template = makeTemplate el
    el.empty()
    renderTemplate template, el
}

if typeof module != 'undefined'
  module.exports = reactiveTemplate
else
  window.ReactiveTemplate = reactiveTemplate
