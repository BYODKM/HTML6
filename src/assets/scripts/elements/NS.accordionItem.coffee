window.NS.accordionItem = (id)->
  radio = document.getElementById(id)
  if (radio.checked)
    radio.checked = false
  else
    radio.checked = true
  return
