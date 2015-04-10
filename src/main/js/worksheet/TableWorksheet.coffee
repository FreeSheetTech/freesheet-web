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
      rowEl = cell.parent()
      cells = rowEl.find('td')
      nameEl = cells.eq(0)
      name  = nameEl.text().trim()
      formulaEl = cells.eq(1)
      formula  = formulaEl.text().trim()
      self.updateFormula name, formula

  updateFormula: (name, formula) -> if name and formula then @loader.setFunctionAsText name, formula


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
    rowEl = @el.find("tbody tr").eq(rowIndex)
    cells = rowEl.find('td')
    nameEl = cells.eq(0)
    nameEl.text name
    formulaEl = cells.eq(1)
    formulaEl.text formula

  _loadTable: (defs) -> @loadRow(i, def.name, def.expr.text) for def, i in defs

  _parseTable:  ->
    sheetRows = @el.find('tr')
    self = this
    sheetRows.each ->
      rowEl = $(this)
      cells = rowEl.find('td')
      nameEl = cells.eq(0)
      name  = nameEl.text().trim()
      formulaEl = cells.eq(1)
      formula  = formulaEl.text().trim()
      self.updateFormula name, formula

  _updateTable: (name, value) ->
    valueCellForName = @el.find('td:first-child').filter( -> $(this).text() == name).closest('tr').find('td:nth-child(3)')
    valueCellForName.text(value)

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet