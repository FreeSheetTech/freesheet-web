ReactiveRunner = require('reactive-runner')
TextParser = require('text-parser')
PageFunctions = require('page-functions')


class TableWorksheet

  constructor: (@el, changeCallback) ->
    @runner = new ReactiveRunner()
    @runner.onChange changeCallback
    @runner.addProvidedStreams PageFunctions
    @_parseTable @runner
    @runner.onChange (name, value) => @_updateTable name, value

  _parseTable: (runner) ->
    parseFormula = (name, formula) -> new TextParser("#{name} = #{formula}").functionDefinition()
    updateFormula = (name, formula) -> if name and formula then runner.addUserFunction parseFormula(name, formula)

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