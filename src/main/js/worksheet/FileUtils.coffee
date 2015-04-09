class FileUtils

  save: (text, name) ->
    blob = new Blob [text], {type: "text/plain;charset=utf-8"}
    saveAs blob, name

  load: (file, callback) ->
    try
      reader = new FileReader()
      reader.onload = -> callback file, reader.result
      reader.readAsText file
    catch error
      console.error "Could not read file: " + error

window.FileUtils = FileUtils
