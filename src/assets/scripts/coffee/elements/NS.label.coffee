window.NS.label = (id)->

  if (!document.getElementById(id))             then return else elem = document.getElementById(id)
  if (elem.nodeName.toLowerCase() isnt 'input') then return else input = elem

  if (!input.checked)
    input.checked = true
  else if (input.getAttribute('type') is 'checkbox')
    input.checked = false

  return
