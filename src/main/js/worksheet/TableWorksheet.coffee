{FunctionError, CalculationError} = require 'freesheet-errors'

_ = require 'lodash'

class TableWorksheet

  minRows = 5

  isPlainObjectArray = (value) ->
    _.isArray(value) and _.every(value, (x) -> _.isPlainObject x)

  htmlFor = (value) ->
    switch
      when value == null or value == undefined then ''
      when isPlainObjectArray value then htmlForObjectArray value
      when _.isArray value then htmlForValueArray value
      when _.isPlainObject value then htmlForObject value
      else value.toString()

  collectObjectKeyNames = (objects) ->
    result = []
    for o in objects
      for k, v of o
        result.push k if not _.includes result, k

    result

  htmlForObjectArray = (value) ->
#    console.log 'htmlForObjectArray'
    keyNames = collectObjectKeyNames value
    headerNames = keyNames
    headerCell = (name) -> "<th>#{name}</th>"
    dataCell = (obj, name) -> "<td>#{htmlFor obj[name]}</td>"
    headerRow = "<tr>#{(headerCell x for x in headerNames).join('')}</tr>"
    rowHtml = (obj) -> "<tr>#{(dataCell obj, x for x in keyNames).join('')}</tr>"
    """<table class='value'>
          #{headerRow}\n
          #{(rowHtml x for x in value).join('\n')}
       </table>"""

  htmlForValueArray = (value) ->
    rowHtml = (x) -> "<tr><td>#{htmlFor x}</td></tr>"
    "<table class='value'> #{(rowHtml x for x in value).join('')} </table>"

  htmlForObject = (value) ->
    rowHtml = (name, x) -> "<tr><td>#{name}</td><td>#{htmlFor x}</td></tr>"
    "<table class='value'> #{(rowHtml(name, x) for name, x of value).join('')} </table>"

  renderValue = (instance, td, row, col, prop, value, cellProperties) ->
    $(td).html(htmlFor(value)).addClass('value-cell')

  dataFromDefAndValues = (defs) ->
    defs.map (d) ->
      {name: d.name, formula: d.definition.expr.text, value: displayValue(d.value)}

  formulaError = (error) -> "Formula error on line #{error.line} at position #{error.columnInExpr}"
  calculationError = (error) -> "#{error.functionName}: #{error.message}"
  displayValue = (v) -> switch
      when v instanceof CalculationError then calculationError v
      when v instanceof FunctionError then formulaError v
      else v


  emptyRow = () -> {name: null, formula: null, value: null}

  constructor: (el, @sheet) ->
    @sheet.onFormulaChange => @_rebuildTable()
    @sheet.onValueChange (name, value) => @_updateTable name, value
    @data = []

    @table = new Handsontable el.get(0), {
      data: @data
      contextMenu: ["row_above", "row_below", "remove_row", "undo", "redo"]
      minSpareRows: 1
      dataSchema: emptyRow()
      colHeaders: ['Name', 'Formula', 'Value']
      columns: [
        {data: 'name', validator: new RegExp('[A-Za-z]\w*|')}
        {data: 'formula'}
        {data: 'value', readOnly: true, renderer: renderValue}
      ]
      autoWrapRow: true
      rowHeaders: true
    }
    @_handleEvents()
    @_rebuildTable()

  _handleEvents: ->
    self = this
    @table.addHook 'afterChange', (changes, source) ->
#      console.log 'afterChange', changes
      for change in (changes or [])
        [rowIndex, propertyName, oldValue, newValue] = change
        row = self.data[rowIndex]
        oldName = if propertyName == 'name' then oldValue else null
        nextRowName = self.data[rowIndex + 1..].filter( (x) -> x.name)[0]?.name
        self.updateFormula row.name, row.formula, oldName, nextRowName

    @table.addHook 'beforeRemoveRow', (index, numberOfRows) ->
#      console.log 'beforeRemoveRow', index, numberOfRows, self.data
      rowsToRemove = (row.name for row in self.data[index...index + numberOfRows])
      self.sheet.remove row.name for row in rowsToRemove

  updateFormula: (name, formula, oldName, nextName) ->
#    console.log 'updateFormula', name, formula, oldName, nextName
    if name and formula then @sheet.update name, formula, oldName, nextName
    if name and not formula then @sheet.update name, 'none', oldName, nextName
    if not name and oldName then @sheet.remove oldName


  asText: -> @sheet.text()

  loadText: (text) ->
    @sheet.clear()
    @sheet.load text
    @_rebuildTable()

  _rebuildTable:  ->
    @data[..] = dataFromDefAndValues(@sheet.formulasAndValues())
    rowsToShow = Math.max minRows, @data.length + 1
    @data.push emptyRow() for i in [@data.length...rowsToShow]
    @table.render()

  _updateTable: (name, value) ->
    row.value = value for row in @data when row.name == name
    @table.render()

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet
