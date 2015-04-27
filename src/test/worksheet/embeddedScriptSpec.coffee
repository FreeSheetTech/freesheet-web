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
    removeTestElements()

  it 'are loaded and available when loadScripts called', ->
    insertScript 'scriptOne', '''a = 10; b = 20; c = a + b'''
    Freesheet.loadScripts()
    s = Freesheet.sheets('scriptOne')
    changes = []
    storeChanges = (name, value) -> received = {}; received[name] = value; changes.push received
    s.onChange storeChanges, 'c'

    changes.should.eql [{c: 30}]


