window.NS.rating = (name)->

  checkboxes = document.getElementsByName(name)
  scope      = checkboxes[0].parentNode
  halfStar   = scope.querySelector('.is-half')

  if (!halfStar) then return

  removeEvent = ->
    for checkbox in checkboxes by -1
      checkbox.removeEventListener('click', removeClass, false)
    return

  removeClass = ->
    a = halfStar.className.split(' ')
    a = a.filter (x)-> return x isnt 'is-half'
    halfStar.className = a.join(' ')
    removeEvent()
    return

  for checkbox in checkboxes by -1
    checkbox.addEventListener('click', removeClass, false)

  return
