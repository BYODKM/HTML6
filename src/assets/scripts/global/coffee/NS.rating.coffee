window.NS.rating = (nameAttr)->

  checkboxes = document.getElementsByName(nameAttr)
  scope = checkboxes[0].parentNode

  removeHalf = ->
    star = scope.querySelector('.is-half')
    a = star.className.split(' ')
    a = a.filter (x)-> return x isnt 'is-half'
    star.className = a.join(' ')
    return

  for checkbox in checkboxes by -1
    checkbox.addEventListener('click', removeHalf, false)

  return
