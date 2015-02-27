window.NS.label = (id)->

  input = document.getElementById(id)
  if (!input) then return

  if (input.checked)
    input.checked = false
  else
    input.checked = true

  return
