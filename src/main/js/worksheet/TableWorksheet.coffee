{FunctionError, CalculationError} = require 'freesheet-errors'

_ = require 'lodash'

class TableWorksheet

  minRows = 5

  isPlainObjectArray = (value) ->
    _.isArray(value) and _.every(value, (x) -> _.isPlainObject x)

  htmlFor = (value) ->
    switch
      when value == null or value == undefined then ''
      when _.isFunction value then 'Function'
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

  renderName = (instance, td, row, col, prop, value, cellProperties) ->
    def = instance.getData()[row]?.definition
    $(td).html(htmlForFunction(def)).addClass('name-cell')

  htmlForFunction = (def) ->
    if not def then "" else displayNameAndArgs def

  dataFromDefAndValues = (defs) ->
    defs.map (d) ->
      definition: d.definition
      name: d.name
      nameAndArgs: displayNameAndArgs d.definition
      formula: displayFormula d.definition.expr
      value: displayValue d.value

  displayNameAndArgs = (def) ->
    if def.argDefs?.length
      argList = (arg.name for arg in def.argDefs).join(',')
      "#{def.name}(#{argList})"
    else def.name

  formulaError = (error) -> "Formula error on line #{error.line} at position #{error.columnInExpr}"
  calculationError = (error) -> "#{error.functionName}: #{error.message}"
  displayValue = (v) -> switch
      when v instanceof CalculationError then calculationError v
      when v instanceof FunctionError then formulaError v
      else v

  displayFormula = (expr) -> if expr.text == 'none' then '' else expr.text

  emptyRow = () -> {definition: null, name: null, nameAndArgs: null, formula: null, value: null}

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
        {data: 'nameAndArgs', renderer: renderName}  #validator: new RegExp('[A-Za-z]\w*|')
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
        oldName = if propertyName == 'nameAndArgs' then row.name else null
        nextRowName = self.data[rowIndex + 1..].filter( (x) -> x.name)[0]?.name
        self.updateFormula row.nameAndArgs, row.formula, oldName, nextRowName

    @table.addHook 'beforeRemoveRow', (index, numberOfRows) ->
#      console.log 'beforeRemoveRow', index, numberOfRows, self.data
      rowsToRemove = (row.name for row in self.data[index...index + numberOfRows])
      self.sheet.remove row.name for row in rowsToRemove

  updateFormula: (nameAndArgs, formula, oldName, nextName) ->
    console.log 'updateFormula', nameAndArgs, formula, oldName, nextName
    if nameAndArgs and formula then @sheet.update nameAndArgs, formula, oldName, nextName
    if nameAndArgs and not formula then @sheet.update nameAndArgs, 'none', oldName, nextName
    if not nameAndArgs and oldName then @sheet.remove oldName


  name: -> @sheet.name
  asText: -> @sheet.text()

  loadText: (text) ->
    @sheet.clear()
    @sheet.load text
    @_rebuildTable()

  redisplay: -> @table.render()

  _rebuildTable:  ->
    @data[..] = dataFromDefAndValues(@sheet.formulasAndValues())
    rowsToShow = Math.max minRows, @data.length + 1
    @data.push emptyRow() for i in [@data.length...rowsToShow]
    @table.render()

  _updateTable: (name, value) ->
    row.value = value for row in @data when row.name == name
    @table.render()

if typeof module != 'undefined'
  module.exports = TableWorksheet
else
  window.TableWorksheet = TableWorksheet
