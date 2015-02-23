window.NS.rating = (nameAttr)->

  checkboxes = document.getElementsByName(nameAttr)
  scope = checkboxes[0].parentNode

  removeHalf = ->
    hlf = scope.querySelector('.is-half')
    tmp = hlf.className.split(' ')
    tmp = tmp.filter (arr)-> return arr isnt 'is-half'
    hlf.className = tmp.join(' ')
    return

  for checkbox in checkboxes by -1
    checkbox.addEventListener('click', removeHalf, false)

  return
