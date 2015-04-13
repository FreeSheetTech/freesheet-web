class TableHandler

  constructor: (@el) ->
    @body = el.find('tbody')
    @el.editableTableWidget();


  addRow: ->
    $('<tr><td></td><td></td><th></th></tr>').appendTo @body
    @el.editableTableWidget();

  addRows: (n) -> @addRow() for i in [1..n]

window.TableHandler = TableHandler