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
    @data = [
      {name: null, formula: null, value: null}
    ]
    @table = new Handsontable el.get(0), {
      data: @data
      contextMenu: ["row_above", "row_below", "remove_row", "undo", "redo"]
      minSpareRows: 1
      dataSchema: {name: null, formula: null, value: null}
      colHeaders: ['Name', 'Formula', 'Value']
      columns: [
        {data: 'name'}
        {data: 'formula'}
        {data: 'value', readOnly: true, renderer: renderValue}
      ]
      autoWrapRow: true
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


#    @el.on 'rowDeleted', (e, removedRow) ->
#      row = new Row(removedRow)
#      self.loader.removeFunction row.name()

  updateFormula: (name, formula, oldName, nextName) ->
    console.log 'updateFormula', name, formula, oldName, nextName
    if name and formula then @loader.setFunctionAsText name, formula, oldName, nextName
    if name and not formula then @loader.removeFunction name
    if not name and oldName then @loader.removeFunction oldName


  asText: -> @loader.asText()

  loadText: (text) ->
    defs = @loader.parseDefinitions(text)
    @data = @_dataFromDefs defs
    @table.loadData @data
    @loader.loadDefinitions text

  _dataFromDefs: (defs) -> defs.map (d) -> {name: d.name, formula: d.expr.text, value: null}

  _updateTable: (name, value) ->
    @_rowForName(name)?.value = value
    r.value = null for r in @data when !r.name or !r.value
    @table.render()

  _rowForName: (name) ->
    (r for r in @data when r.name == name)[0]


#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet
