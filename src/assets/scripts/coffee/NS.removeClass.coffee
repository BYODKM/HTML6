window.NS.removeClass = (elm, str)->
  a = []
  s = str.replace('.', '')
  a = elm.className.split(' ')
  a = a.filter (x)->
    return x isnt s
  elm.className = a.join(' ')
  return
