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

  renderValue = (instance, td, row, col, prop, value, cellProperties) ->
    $(td).html(htmlFor(value)).addClass('value-cell')


  constructor: (el, @changeCallback) ->
    @runner = new ReactiveRunner()
    @runner.onChange @changeCallback
    @runner.addProvidedStreams CoreFunctions
    @runner.addProvidedStreams TimeFunctions
    @runner.addProvidedStreams PageFunctions
    @runner.onChange (name, value) => @_updateTable name, value
    @loader = new TextLoader(@runner)
    @data = ({name: null, formula: null, value: null} for i in [1..5] )

    @table = new Handsontable el.get(0), {
      data: @data
      contextMenu: ["row_above", "row_below", "remove_row", "undo", "redo"]
      minSpareRows: 1
      dataSchema: {name: null, formula: null, value: null}
      colHeaders: ['Name', 'Formula', 'Value']
      columns: [
        {data: 'name', validator: new RegExp('[A-Za-z]\w*')}
        {data: 'formula'}
        {data: 'value', readOnly: true, renderer: renderValue}
      ]
      autoWrapRow: true
      rowHeaders: true
    }
    @_handleEvents()

  _handleEvents: ->
    self = this
    @table.addHook 'afterChange', (changes, source) ->
      console.log 'afterChange', changes
      for change in (changes or [])
        [rowIndex, propertyName, oldValue, newValue] = change
        row = self.data[rowIndex]
        oldName = if propertyName == 'name' then oldValue else null
        nextRowName = self.data[rowIndex + 1..].filter( (x) -> x.name)[0]?.name
        self.updateFormula row.name, row.formula, oldName, nextRowName

    @table.addHook 'beforeRemoveRow', (index, numberOfRows) ->
      console.log 'beforeRemoveRow', index, numberOfRows, self.data
      for row in self.data[index...index + numberOfRows]
        console.log 'Removing row', row
        self.loader.removeFunction row.name

  updateFormula: (name, formula, oldName, nextName) ->
    console.log 'updateFormula', name, formula, oldName, nextName
    if name and formula then @loader.setFunctionAsText name, formula, oldName, nextName
    if name and not formula then @loader.removeFunction name
    if not name and oldName then @loader.removeFunction oldName


  asText: -> @loader.asText()

  loadText: (text) ->
    @loading = true
    @loader.clear()
    @data.length = 0
    @loader.loadDefinitions text
    @_newRow null
    @loading = false

  _dataFromDefs: (defs) -> defs.map (d) -> {name: d.name, formula: d.expr.text, value: null}

  _updateTable: (name, value) ->
    @_rowForName(name)?.value = value
    r.value = null for r in @data when !r.name or !r.value
    @table.render()

  _rowForName: (name) ->
    existingRow = (r for r in @data when r.name == name)[0]
    if @loading then existingRow or @_newRow(name) else existingRow

  _newRow: (name) ->
    def = (d for d in @loader.functionDefinitions() when d.name == name)[0]
    row = {name: def?.name, formula: def?.expr.text, value: null}
    @data.push row
    row


#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet
