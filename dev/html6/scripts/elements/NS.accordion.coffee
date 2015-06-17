window.NS.accordion = (id)->

  loaded = ->

    nodes = document.querySelectorAll('.accordion__item__block')

    for node in nodes by -1
      node.setAttribute('style', 'height:' + node.scrollHeight + 'px;')

    delay = ->
      for node in nodes by -1
        node.className += ' is-loaded'
      return

    setTimeout(delay, 300)

    return

  window.addEventListener('load', loaded, false)

  return
