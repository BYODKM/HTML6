ready = ->

  scope = document.getElementById('page--index')
  if (!scope) then return

  FastClick.attach(document.body)

  return

document.addEventListener('DOMContentLoaded', ready, false)
