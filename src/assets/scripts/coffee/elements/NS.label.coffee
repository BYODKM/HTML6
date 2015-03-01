window.NS.label = (id)->

  elem = document.getElementById(id)

  if (elem and elem.nodeName.toLowerCase() isnt 'input')   then return
  if (input.getAttribute('type') is 'checkbox' or 'radio') then input = elem else return

  if (!input.checked)
    input.checked = true
  else if (input.getAttribute('type') is 'checkbox')
    input.checked = false

  return
