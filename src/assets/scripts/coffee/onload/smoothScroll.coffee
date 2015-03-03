smoothScroll = ->

  if (!document.documentElement) then return else $html  = document.documentElement
  if (!document.body)            then return else $body  = document.body
  if (!document.links.length)    then return else $links = document.links

  options =
    totalTime    : 500
    refreshRate  : 15
    disableClass : '.disabled--smoothScroll'

  clicked = (e)->

    $link = this
    e.preventDefault()

    ignoreTouch = (e)->
      e.preventDefault()
      return
    $body.addEventListener('touchstart', ignoreTouch, false)

    id = $link.hash.replace('#', '').replace(/\?.*/, '')
    $target = document.getElementById(id)

    targetScrollTop = (elem)->
      px = 0
      while(elem)
        px  += elem.offsetTop || 0
        elem = elem.offsetParent
      return px

    goal = targetScrollTop($target)
    if (goal > $html.scrollHeight - window.innerHeight) then goal = $html.scrollHeight - window.innerHeight
    if (goal < 0) then goal = 0

    equation = (a, b, c, d)-> return a * b / c + d
    currentScrollTop = -> return ($html.scrollTop || $body.scrollTop)
    startTime = new Date()

    scroll = ->
      lapseTime = new Date() - startTime
      oneStep = equation((goal - currentScrollTop()), lapseTime, options.totalTime, currentScrollTop())
      if (options.totalTime > lapseTime + options.refreshRate)
        window.scrollTo(0, parseInt(oneStep))
        setTimeout(scroll, options.refreshRate)
      else
        window.scrollTo(0, parseInt(goal))
        $body.removeEventListener('touchstart', ignoreTouch, false)
      return
    scroll()

    return

  for $link in $links by -1
    if ($link.getAttribute('href').substring(0, 1) isnt '#') then continue
    if ($link.className.indexOf(options.disableClass.replace('.', '')) >= 0) then continue
    id = $link.hash.replace('#', '').replace(/\?.*/, '')
    if (id && document.getElementById(id))
      $link.addEventListener('click', clicked, false)

  return

window.addEventListener('load', smoothScroll, false)
