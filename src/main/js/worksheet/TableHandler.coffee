class TableHandler

  constructor: (@tableEl) ->
    @body = tableEl.find('tbody')
    @tableEl.editableTableWidget();


  addRow: -> @_newRow().appendTo(@body).find('td').empty()

  addRows: (n) -> @addRow() for i in [1..n]

  insertAboveRow: (aboveEl) -> @_newRow().insertBefore @_rowContaining(aboveEl)

  deleteRow: (el) ->
    removedRow = @_rowContaining(el).remove()
    @tableEl.trigger 'rowDeleted', [removedRow]

  _newRow: -> @body.find('tr').eq(0).clone().find('.name, .formula, .value').empty().end()
  _rowContaining: (el) -> $(el).closest 'tr'

window.TableHandler = TableHandler

