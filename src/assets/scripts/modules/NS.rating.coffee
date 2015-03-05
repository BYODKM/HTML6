window.NS.rating = (name)->

  checkboxes = document.getElementsByName(name)
  scope = checkboxes[0].parentNode

  removeHalf = ->
    half = scope.querySelector('.is-half')
    if (!half) then return
    tmp = half.className.split(' ')
    tmp = tmp.filter (arr)-> return arr isnt 'is-half'
    half.className = tmp.join(' ')
    return

  for checkbox in checkboxes by -1
    checkbox.addEventListener('click', removeHalf, false)

  return
