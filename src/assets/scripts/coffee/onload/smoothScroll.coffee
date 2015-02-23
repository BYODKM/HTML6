smoothScroll = ->

  options =
    totalTime: 500
    refreshRate: 15
    disableClass: '.js--smoothScroll-off'

  links = document.links
  if (!links.length) then return

  scroll = (e)->

    e.preventDefault()

    touch = (e)->
      e.preventDefault()
      return
    body = document.body
    if (!body) then return
    body.addEventListener('touchstart', touch, false)

    windwowH = window.innerHeight
    documentH = document.documentElement.scrollHeight
    scrollable = documentH - windwowH
    if (scrollable < 0) then return

    scrolled = -> return (document.documentElement.scrollTop || body.scrollTop)

    target = this.hash.replace('#', '').replace(/\?.*/, '')
    target = document.getElementById(target)

    scaleFromTop = (x)->
      n = 0
      while(x)
        n += x.offsetTop || 0
        x = x.offsetParent
      return n
    goal = scaleFromTop(target)
    if (goal < 0) then goal = 0
    if (goal > scrollable) then goal = scrollable

    equation = (a, b, c, d)-> return a * b / c + d

    startTime = new Date()

    run = ->
      lapseTime = new Date() - startTime
      oneCycle = equation((goal - scrolled()), lapseTime, options.totalTime, scrolled())
      if (options.totalTime > lapseTime + options.refreshRate)
        window.scrollTo(0, parseInt(oneCycle))
        setTimeout(run, options.refreshRate)
      else
        window.scrollTo(0, parseInt(goal))
        body.removeEventListener('touchstart', touch, false)
      return
    run()

    return

  for link in links by -1
    if (link.getAttribute('href').substring(0, 1) isnt '#') then continue
    if (link.className.indexOf(options.disableClass.replace('.', '')) >= 0) then continue
    id = link.hash.replace('#', '').replace(/\?.*/, '')
    if (id && document.getElementById(id))
      link.addEventListener('click', scroll, false)

  return

window.addEventListener('load', smoothScroll, false)
