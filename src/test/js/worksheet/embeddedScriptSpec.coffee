describe 'Freesheet scripts embedded in pages', ->

#  Freesheet = require 'freesheet-web'

  testElements = []

  insertScript = (id, text) -> insertElement "<script id='#{id}' type='text/freesheet'>#{text}</script>"

  insertElement = (el) ->
    jqEl = $(el)
    testElements.push jqEl
    jqEl.appendTo $(document.body)

  removeTestElements = -> el.remove() for el in testElements

  beforeEach ->
    testElements = []

  afterEach ->
    removeTestElements() unless location.href.indexOf 'debug' != -1

  it 'are loaded and available when loadScripts called', ->
    insertScript 'scriptOne', '''a = 10; b = 20; c = a + b'''
    Freesheet.loadScripts()
    s = Freesheet.sheets('scriptOne')
    changes = []
    storeChanges = (name, value) -> received = {}; received[name] = value; changes.push received
    s.onValueChange storeChanges, 'c'

    changes.should.eql [{c: 30}]

  it 'can create a worksheet when createWorksheets called', ->
    insertScript 'scriptTwo', '''d = 30; e = 20; f = d - e'''
    worksheetDiv = insertElement '<div class="freesheet-worksheets"></div>'
    Freesheet.loadScripts()
    Freesheet.createWorksheets()

    sheetDiv = worksheetDiv.find 'div#scriptTwo_worksheet'
    sheetTable = sheetDiv.find '.ht_master table.htCore'
    eValueCell = sheetTable.find('tbody tr:nth-child(3) td.value-cell')
    eValueCell.text().should.eql '10'
