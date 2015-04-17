ReactiveRunner = require('reactive-runner')
TextLoader = require('text-loader')
TextParser = require('text-parser')
CoreFunctions = require('core-functions')
PageFunctions = require('page-functions')
TimeFunctions = require('time-functions')


class TableWorksheet

  htmlFor = (value) ->
    switch
      when value == null or value == undefined then ''
      when $.isArray value then htmlForArray value
      when $.isPlainObject value then htmlForObject value
      else value.toString()

  htmlForArray = (value) ->
    rowHtml = (x) -> "<tr><td>#{htmlFor x}</td></tr>"
    "<table class='value'> #{(rowHtml x for x in value).join('')} </table>"

  htmlForObject = (value) ->
    rowHtml = (name, x) -> "<tr><td>#{name}</td><td>#{htmlFor x}</td></tr>"
    "<table class='value'> #{(rowHtml(name, x) for name, x of value).join('')} </table>"


  constructor: (@el, @changeCallback) ->
    @runner = new ReactiveRunner()
    @runner.onChange @changeCallback
    @runner.addProvidedStreams CoreFunctions
    @runner.addProvidedStreams TimeFunctions
    @runner.addProvidedStreams TimeFunctions
    @runner.onChange (name, value) => @_updateTable name, value
    @loader = new TextLoader(@runner)
    @_parseTable()
    @_handleEvents()

  _handleEvents: ->
    self = this
    @el.on 'change', 'td', (evt, newValue) ->
      cell = $(this)
      row = new Row(cell.parent())
      oldName = if cell.is(row.nameCell()) then evt.originalContent else null
      self.updateFormula row.name(), row.formula(), oldName, row.nextName()

    @el.on 'rowDeleted', (e, removedRow) ->
      row = new Row(removedRow)
      self.loader.removeFunction row.name()

  updateFormula: (name, formula, oldName, nextName) ->
    console.log 'updateFormula', name, formula, oldName, nextName
    if name and formula then @loader.setFunctionAsText name, formula, oldName, nextName
    if name and not formula then @loader.removeFunction name
    if not name and oldName then @loader.removeFunction oldName


  asText: -> @loader.asText()

  clear: ->
    @loader.clear()
    @el.find('tbody td, tbody th.value').empty()

  loadText: (text) ->
    @clear()
    @_loadTable @loader.parseDefinitions(text)
    @loader.loadDefinitions text

  loadRow: (rowIndex, name, formula) ->
    row = new Row(@el.find("tbody tr").eq(rowIndex))
    row.setName name
    row.setFormula formula

  _loadTable: (defs) -> @loadRow(i, def.name, def.expr.text) for def, i in defs

  _parseTable:  ->
    sheetRows = @el.find('tr')
    self = this
    sheetRows.each ->
      row = new Row($(this))
      self.updateFormula row.name(), row.formula()

  _updateTable: (name, value) -> @_rowForName(name).setValue htmlFor(value)

  _rowForName: (name) ->
    new Row @el.find('td:first-child').filter(-> $(this).text() == name).closest('tr')


class Row
  constructor: (@rowEl) ->

  nameCell: -> @rowEl.find('td.name')
  formulaCell: -> @rowEl.find('td.formula')
  valueCell: -> @rowEl.find('th.value')
  name: -> @nameCell().text().trim()
  formula: -> @formulaCell().text().trim()
  setName: (name) -> @nameCell().text(name)
  setFormula: (name) -> @formulaCell().text(name)
  setValue: (value) -> @valueCell().html(value)

  nextName: ->
    followingRowNames = @rowEl.nextAll().map((i, el) -> new Row($(el)).name()).get()
    (n for n in followingRowNames when n != '')[0]

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet
