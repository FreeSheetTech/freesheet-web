$ ->
  tableEl = $('#sheet')
  table = window.table = new TableHandler(tableEl)
  tableEl.on 'click', 'tbody .actions .insert', (e) -> table.insertAboveRow(e.target)
  tableEl.on 'click', 'tbody .actions .delete', (e) -> table.deleteRow(e.target)

  worksheet = window.worksheet = new TableWorksheet(tableEl, (name, value) -> console.log("Change: " + name + " = " + value))
  fileUtils = window.fileUtils = new FileUtils();

  $('#save').on 'click', -> fileUtils.save worksheet.asText(), $('#name').val()

  loadFile = $('#load')
  fileLoaded = (file, text) ->
    worksheet.loadText text
    $('#name').val(file.name)

  loadFile.on 'change', -> fileUtils.load loadFile.get(0).files[0], fileLoaded

  $('#addRows').on 'click', -> table.addRows(5)
  $('#clear').on 'click', -> worksheet.clear()

