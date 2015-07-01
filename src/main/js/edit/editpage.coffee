Freesheet = require 'freesheet'
CoreFunctions = require 'core-functions'
PageFunctions = require 'page-functions'
TimeFunctions = require 'time-functions'
TableWorksheet = require 'table-worksheet'
FileUtils = require 'file-utils'

$ ->
  freesheet = null
  sheetsEl = $('#sheets')

  newFreesheetEnvironment = ->
    sheetsEl.empty()
    freesheet?.destroy()
    freesheet = new Freesheet()

  newSheet = (name, text) ->
    sheetName = name or "Sheet#{getWorksheets().length + 1}"
    sectionEl = $("""<div class="worksheet-section">
                        <div class="worksheet-name" contenteditable>#{sheetName}</div>
                        <div class="worksheet"></div>
                    </div>""").appendTo sheetsEl

    sheet = freesheet.createSheet sheetName
    sheet.onValueChange (name, value) -> console.log("Change: " + name + " = " + value)
    sheet.addFunctions PageFunctions

    worksheet = new TableWorksheet sectionEl.find('.worksheet'), sheet
    if text then worksheet.loadText text
    sectionEl.data 'worksheet', worksheet

  getWorksheets = -> $('.worksheet-section').map( (i, el) -> $(el).data('worksheet')).get()
  sheetScript = (worksheet) ->
    """<script type="text/freesheet" data-name="#{worksheet.name()}">
          #{worksheet.asText()}
       </script>
      """

  getPageText = ->
    pagePath = location.href.replace /\/[^/]+l$/, ''

    head =  """
              <meta charset="UTF-8">
              <link rel="stylesheet" href="#{pagePath}/css/freesheet-web.css"/>
              <link rel="stylesheet" href="#{pagePath}/css/handsontable.full.css"/>
              <script src="#{pagePath}/js/lib/jquery.js"></script>
              <script src="#{pagePath}/js/lib/freesheet.js"></script>
              <script src="#{pagePath}/js/freesheet-web.js"></script>

              <title>Freesheet Active Page</title>
            """
    content = """<div class="freesheet-template">
                       #{editor.getData()}
                 </div>
              """

    sheetScripts = (sheetScript s for s in getWorksheets()).join('\n')

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
                      #{sheetScripts}
                      #{initScript}
                    </body>
                </html>
              """
    pageHtml

  parsePage = (text) ->
    bodyEl = $ '<div id="body-mock">' + text.replace(/^[\s\S]*<body.*?>|<\/body>[\s\S]*$/g, '') + '</div>';
    pageHtml = bodyEl.find('.freesheet-template').html()
    freesheetScriptEls = bodyEl.find('script[type="text/freesheet"]')
    worksheetScripts = {}
    freesheetScriptEls.each (i, el) ->
      script = $ el
      scriptName = script.attr('data-name')
      scriptText = script.html()
      worksheetScripts[scriptName] = scriptText
    {pageHtml, worksheetScripts}

  # initialise page
  editor = CKEDITOR.replace 'editor', { extraPlugins: 'divarea'}
  fileUtils = window.fileUtils = new FileUtils()

  newFreesheetEnvironment()
  newSheet()

  # handle events

  $('#newSheet').on 'click', -> newSheet()
  $('#save').on 'click', -> fileUtils.save getPageText(), $('#name').val()

  loadFile = $('#load')
  fileLoaded = (file, text) ->
    {pageHtml, worksheetScripts} = parsePage text
    newFreesheetEnvironment()
    newSheet(name, script) for name, script of worksheetScripts
    editor.setData pageHtml
    $('#name').val(file.name)

  loadFile.on 'change', -> fileUtils.load loadFile.get(0).files[0], fileLoaded

