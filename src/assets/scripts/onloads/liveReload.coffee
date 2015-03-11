document.addEventListener('DOMContentLoaded', ->
  if (location.port is '3000')
    script = document.createElement('script')
    script.src = '//localhost:35729/livereload.js'
    document.body.appendChild(script)
, false)
