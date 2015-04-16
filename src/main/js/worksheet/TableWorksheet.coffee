ReactiveRunner = require('reactive-runner')
TextLoader = require('text-loader')
TextParser = require('text-parser')
PageFunctions = require('page-functions')


class TableWorksheet

  constructor: (@el, @changeCallback) ->
    @runner = new ReactiveRunner()
    @runner.onChange @changeCallback
    @runner.addProvidedStreams PageFunctions
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

  _updateTable: (name, value) ->
    valueCellForName = @el.find('td:first-child').filter( -> $(this).text() == name).closest('tr').find('th:nth-child(3)')
    valueCellForName.text(value)

class Row
  constructor: (@rowEl) ->

  nameCell: -> @rowEl.find('td.name')
  formulaCell: -> @rowEl.find('td.formula')
  valueCell: -> @rowEl.find('th.value')
  name: -> @nameCell().text().trim()
  formula: -> @formulaCell().text().trim()
  setName: (name) -> @nameCell().text(name)
  setFormula: (name) -> @formulaCell().text(name)
  setValue: (value) -> @valueCell().text(value)

  nextName: ->
    followingRowNames = @rowEl.nextAll().map((i, el) -> new Row($(el)).name()).get()
    (n for n in followingRowNames when n != '')[0]

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet
