Freesheet = require 'freesheet'
CoreFunctions = require 'core-functions'
PageFunctions = require 'page-functions'
TimeFunctions = require 'time-functions'
TableWorksheet = require 'table-worksheet'
FileUtils = require 'file-utils'

$ ->
  tableEl = $('#sheet')

  sheet = Freesheet.createSheet(tableEl.attr('id') or 'sheet1')
  sheet.onValueChange (name, value) -> console.log("Change: " + name + " = " + value)
  sheet.addFunctions CoreFunctions
  sheet.addFunctions TimeFunctions
  sheet.addFunctions PageFunctions

  editor = CKEDITOR.replace 'editor', { extraPlugins: 'divarea'}
  worksheet = window.worksheet = new TableWorksheet tableEl, sheet
  fileUtils = window.fileUtils = new FileUtils();

  getPageText = ->
    pagePath = location.href.replace /\/[^/]+l$/, ''

    head =  """
              <meta charset="UTF-8">
              <link rel="stylesheet" href="#{pagePath}/../../main/css/freesheet-web.css"/>
              <link rel="stylesheet" href="#{pagePath}/../../main/css/handsontable.full.css"/>
              <script src="#{pagePath}/../../main/js/lib/jquery.js"></script>
              <script src="#{pagePath}/../../main/js/lib/freesheet.js"></script>
              <script src="#{pagePath}/../../../dist/freesheet-web.js"></script>

              <title>Freesheet Active Page</title>
            """
    content = """<div class="content freesheet-template">
                       #{editor.getData()}
                 </div>
              """

    sheetScript = """<script type="text/freesheet" id="sheet1">
                         #{worksheet.asText()}
                      </script>
                  """

    initScript =  """<script>
                      require('freesheet-web').loadScriptsIntoWorksheets();
                      require('reactive-template').convertTemplates();
                  </script>
                  """

    pageHtml = """<html>
                    <head>
                      #{head}
                    </head>
                    <body>
                      #{content}
                      #{sheetScript}
                      #{initScript}
                    </body>
                </html>
              """
    pageHtml

  $('#save').on 'click', -> fileUtils.save getPageText(), $('#name').val()

  loadFile = $('#load')
  fileLoaded = (file, text) ->
    worksheet.loadText text
    $('#name').val(file.name)

  loadFile.on 'change', -> fileUtils.load loadFile.get(0).files[0], fileLoaded

