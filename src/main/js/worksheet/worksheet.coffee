Freesheet = require 'freesheet'
CoreFunctions = require('core-functions')
PageFunctions = require('page-functions')
TimeFunctions = require('time-functions')

$ ->
  tableEl = $('#sheet')

  sheet = Freesheet.createSheet(tableEl.attr('id') or 'sheet1')
  sheet.onValueChange (name, value) -> console.log("Change: " + name + " = " + value)
  sheet.addFunctions CoreFunctions
  sheet.addFunctions TimeFunctions
  sheet.addFunctions PageFunctions

  worksheet = window.worksheet = new TableWorksheet tableEl, sheet
  fileUtils = window.fileUtils = new FileUtils();

  $('#save').on 'click', -> fileUtils.save worksheet.asText(), $('#name').val()

  loadFile = $('#load')
  fileLoaded = (file, text) ->
    worksheet.loadText text
    $('#name').val(file.name)

  loadFile.on 'change', -> fileUtils.load loadFile.get(0).files[0], fileLoaded

