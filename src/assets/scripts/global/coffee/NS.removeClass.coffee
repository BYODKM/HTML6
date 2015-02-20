window.NS.removeClass = (elm, cls)->

  tmp = []
  tmp = elm.className.split(' ')
  tmp = tmp.filter (arr)->
    if (typeof cls is 'string')
      obj = cls.replace('.', '')
      return arr isnt obj
    else if (cls instanceof RegExp)
      return (!arr.match(cls))
    else
      return
  elm.className = tmp.join(' ')

  return
