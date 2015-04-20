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
      contextMenu: true
      startRows: 5
      minSpareRows: 1
      startCols: 3
      dataSchema: {name: null, formula: null, value: null}
      colHeaders: ['Name', 'Formula', 'Value']
      columns: [{data: 'name'}, {data: 'formula'}, {data: 'value'}]
      autoWrapRow: true
    }
#    @_parseTable()
    @_handleEvents()

  _handleEvents: ->
    self = this
    @table.addHook 'afterChange', (changes, source) ->
      console.log 'afterChange', changes
      if !changes or changes.length == 0 then return
      firstChange = changes[0]
      [rowIndex, propertyName, oldValue, newValue] = firstChange
      row = self.data[rowIndex]
      oldName = if propertyName == 'name' then oldValue else null
      nextRowName = self.data[rowIndex + 1..].filter( (x) -> x.name)[0]?.name
      self.updateFormula row.name, row.formula, oldName, nextRowName

#    @el.on 'rowDeleted', (e, removedRow) ->
#      row = new Row(removedRow)
#      self.loader.removeFunction row.name()

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
    defs = @loader.parseDefinitions(text)
    @data = @_dataFromDefs defs
    @table.loadData @data
    @loader.loadDefinitions text

  _dataFromDefs: (defs) -> defs.map (d) -> {name: d.name, formula: d.expr.text, value: null}

  _updateTable: (name, value) ->
    @_rowForName(name).value = htmlFor(value)
    @table.render()

  _rowForName: (name) ->
    @data.filter( (x) -> x.name == name)[0]


class Row
  constructor: (@rowEl) ->

  nameCell: -> @rowEl.find('td.name')
  formulaCell: -> @rowEl.find('td.formula')
  valueCell: -> @rowEl.find('th.value')
  name: -> @nameCell().text().trim()
  formula: -> @formulaCell().text().trim()
  setName: (name) -> @nameCell().text(name)
  setFormula: (name) -> @formulaCell().text(name)
  setValue: (value) -> @valueCell().html(value)

  nextName: ->
    followingRowNames = @rowEl.nextAll().map((i, el) -> new Row($(el)).name()).get()
    (n for n in followingRowNames when n != '')[0]

#module.exports = TableWorksheet
window.TableWorksheet = TableWorksheet
