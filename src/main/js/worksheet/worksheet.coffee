$ ->
  worksheet = window.worksheet = new TableWorksheet($('#sheet'), (name, value) -> console.log("Change: " + name + " = " + value))
  fileUtils = window.fileUtils = new FileUtils();

  $('#save').on 'click', -> fileUtils.save worksheet.asText(), $('#name').val()
  loadFile = $('#load')
  loadFile.on 'change', -> fileUtils.load loadFile.get(0).files[0], (text) -> worksheet.loadText text
