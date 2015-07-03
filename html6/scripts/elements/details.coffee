window.HTML6.details = ->
  window.addEventListener('load', ->
    nodes = document.querySelectorAll('.details__block')
    for node in nodes by -1
      node.setAttribute('style', 'height:' + node.scrollHeight + 'px;')
    return
  , false)
  return
