window.NS.label = (id)->

  if (!document.getElementById(id))             then return else elem  = document.getElementById(id)
  if (elem.nodeName.toLowerCase() isnt 'input') then return else input = elem

  if (input.getAttribute('type') is 'radio')
    if (!input.checked) then input.checked = true

  if (input.getAttribute('type') is 'checkbox')
    if (!input.checked) then input.checked = true else input.checked = false

  return
