ReactiveRunner = require('reactive-runner')
TextParser = require('text-parser')
PageFunctions = require('page-functions')


class TableWorksheet

  namedFormulasFromText = (text) ->
    lines = text.split '\n'
    splitLine = (line) ->
      parts = line.split '='
      {name: parts[0], formula: parts[1]}

    (splitLine line for line in lines)


  constructor: (@el, @changeCallback) ->
    @initRunnerFromTable()

  initRunnerFromTable: ->
    @runner = new ReactiveRunner()
    @runner.onChange @changeCallback
    @runner.addProvidedStreams PageFunctions
    @runner.onChange (name, value) => @_updateTable name, value
    @_parseTable()

  asText: ->
    sheetRows = @el.find('tr')
    text = ''
    sheetRows.each ->
      rowEl = $(this)
      cells = rowEl.find('td')
      nameEl = cells.eq(0).find('input')
      name  = nameEl.val().trim()
      formulaEl = cells.eq(1).find('input')
      formula  = formulaEl.val().trim()
      if name and formula then text += name + ' = ' + formula + ';' + '\n'

    text

  clear: ->
    @el.find('input').val ''
    @el.find('td:nth-child(3)').text ''

  loadText: (text) ->
    @clear()
    @loadRow r, nf.name, nf.formula for nf, r in namedFormulasFromText text
    @initRunnerFromTable()

  loadRow: (rowIndex, name, formula) ->
    rowEl = @el.find("tr").eq(rowIndex)
    cells = rowEl.find('td')
    nameEl = cells.eq(0).find('input')
    nameEl.val name
    formulaEl = cells.eq(1).find('input')
    formulaEl.val formula

  _parseTable:  ->
    runner = @runner
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