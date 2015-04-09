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
    nameEl = cells.eq(0).find('input')
    nameEl.val name
    formulaEl = cells.eq(1).find('input')
    formulaEl.val formula

  _loadTable: (defs) -> @loadRow(i, def.name, def.expr.text) for def, i in defs

  _parseTable:  ->
    loader = @loader
    updateFormula = (name, formula) -> if name and formula then loader.setFunctionAsText name, formula

    sheetRows = @el.find('tr')
    sheetRows.each ->
      rowEl = $(this)
      cells = rowEl.find('td')
      nameEl = cells.eq(0).find('input')
      name  = nameEl.val().trim()
      formulaEl = cells.eq(1).find('input')
      formula  = formulaEl.val().trim()
      updateFormula name, formula

      rowEl.on 'change', -> updateFormula nameEl.val().trim(), formulaEl.val().trim()

  _updateTable: (name, value) ->
    valueCellForName = @el.find('td:first-child input').filter( -> $(this).val() == name).closest('tr').find('td:nth-child(3)')
    valueCellForName.text(value)

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet