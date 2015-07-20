Freesheet = require 'freesheet'
CoreFunctions = require 'core-functions'
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
    if not name
      alert 'You need to enter the sheet name'
      return

    sheetNo = getWorksheets().length + 1
    sheetName = name or "Sheet#{sheetNo}"
    sectionEl = $("""<div class="worksheet-section">
                        <div class="worksheet-with-text">
                          <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation"  class="disabled" ><a class="worksheet-name">#{sheetName}</a></li>
                            <li role="presentation" class="active"><a href="#sheet#{sheetNo}" aria-controls="sheet#{sheetNo}" role="tab" data-toggle="tab">Worksheet</a></li>
                            <li role="presentation"><a href="#text#{sheetNo}" aria-controls="text#{sheetNo}" role="tab" data-toggle="tab">Text</a></li>
                          </ul>
                          <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active worksheet" id="sheet#{sheetNo}"></div>
                            <div role="tabpanel" class="tab-pane" id="text#{sheetNo}"><pre class="text"></pre></div>
                          </div>
                        </div>
                    </div>""").appendTo sheetsEl

    sheet = freesheet.createSheet sheetName
    sheet.onValueChange (name, value) -> console.log("Change: " + name + " = " + value)

    worksheet = new TableWorksheet sectionEl.find('.worksheet'), sheet, sectionEl.find('.text')
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
            <link rel="stylesheet" href="#{pagePath}/css/handsontable.full.css"/>
            <link rel="stylesheet" href="#{pagePath}/css/bootstrap.css"/>
            <link rel="stylesheet" href="#{pagePath}/css/bootstrap-theme.css"/>
            <link rel="stylesheet" href="#{pagePath}/css/freesheet-web.css"/>
            <script src="#{pagePath}/js/lib/jquery.js"></script>
            <script src="#{pagePath}/js/lib/bootstrap.js"></script>
            <script src="#{pagePath}/js/lib/freesheet.js"></script>
            <script src="#{pagePath}/js/freesheet-web.js"></script>

            <title>Freesheet Active Page</title>
            """
    sheetScripts = (sheetScript s for s in getWorksheets()).join('\n')

    initScript =  """
                  <script>
                      require('freesheet-web').initPage();
                      require('reactive-template').convertTemplates();
                  </script>
                  """

    pageHtml = """
               <html>
                    <head>
                      #{head}
                    </head>
                    <body>
                      <div class="freesheet-template">
                               #{editor.getData()}
                      </div>
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
  editor = CKEDITOR.replace 'editor',
    extraPlugins: 'divarea,div,forms'
    allowedContent: true

  fileUtils = window.fileUtils = new FileUtils()

  newFreesheetEnvironment()
  newSheet('Sheet 1')

  # handle events

  $('#newSheet').on 'click', (event) ->
    newSheet $('#sheetName').val()
    event.preventDefault()

  $('#save').on 'click', ->
    fileUtils.save getPageText(), $('#name').text()

  loadFile = $('#open')
  fileLoaded = (file, text) ->
    {pageHtml, worksheetScripts} = parsePage text
    newFreesheetEnvironment()
    newSheet(name, script) for name, script of worksheetScripts
    editor.setData pageHtml
    $('#name').text(file.name)

  loadFile.on 'click', -> loadFile.val ''
  loadFile.on 'change', -> fileUtils.load loadFile.get(0).files[0], fileLoaded

