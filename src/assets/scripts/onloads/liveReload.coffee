if (location.port is '3000')
  document.addEventListener('DOMContentLoaded', ->
    script = document.createElement('script')
    script.src = '//localhost:35729/livereload.js'
    document.body.appendChild(script)
    return
  , false)
