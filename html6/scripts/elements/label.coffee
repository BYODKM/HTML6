window.HTML6.label = (obj)->

  id = obj.for

  if (!document.getElementById(id))             then return else elem  = document.getElementById(id)
  if (elem.nodeName.toLowerCase() isnt 'input') then return else input = elem

  if (input.getAttribute('type') is 'radio')
    if (!input.checked) then input.checked = true
    return

  if (input.getAttribute('type') is 'checkbox')
    if (!input.checked) then input.checked = true else input.checked = false
    return

  if (input.getAttribute('type') is 'text')
    if (input isnt document.activeElement) then input.focus()
    return
