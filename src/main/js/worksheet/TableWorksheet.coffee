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
      self.updateFormula row.name(), row.formula(), oldName

  updateFormula: (name, formula, oldName) ->
    console.log 'updateFormula', name, formula, oldName
    if name and formula then @loader.setFunctionAsText name, formula, oldName
    if name and not formula then @loader.removeFunction name
    if not name and oldName then @loader.removeFunction oldName


  asText: -> @loader.asText()

  clear: ->
    @loader.clear()
    @el.find('input').val ''
    @el.find('td:nth-child(3)').text ''

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

  nameCell: -> @rowEl.find('td').eq(0)
  formulaCell: -> @rowEl.find('td').eq(1)
  valueCell: -> @rowEl.find('th')
  name: -> @nameCell().text().trim()
  formula: -> @formulaCell().text().trim()
  setName: (name) -> @nameCell().text(name)
  setFormula: (name) -> @formulaCell().text(name)
  setValue: (value) -> @valueCell().text(value)

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet