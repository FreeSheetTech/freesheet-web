describe 'Freesheet scripts embedded in pages', ->

  it.skip 'are loaded and available when loadScripts called', ->
    insertScript 'scriptOne', '''a = 10; b = 20; c = a + b'''
    Freesheet.loadScripts()
    s = Freesheet.sheets('scriptOne')
    changes = []
    storeChanges = (value) -> changes.push value
    s.onChange storeChanges, 'c'

    changes.should.eql[{c: 30}]


