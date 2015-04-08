window.NS.accordion = ->
  window.addEventListener('load', ->

  nodes = document.querySelectorAll('.accordion__item__block')

  for node in nodes by -1
    node.setAttribute('style', 'height:' + node.scrollHeight + 'px;')

  setTimeout ->
    for node in nodes by -1
      node.className += ' is-loaded'
    return
  , 500

  , false)
  return
