(function() {
  window.removeClass = function(elm, str) {
    var a, s;
    a = [];
    s = str.replace('.', '');
    a = elm.className.split(' ');
    a = a.filter(function(x) {
      return x !== s;
    });
    elm.className = a.join(' ');
  };

}).call(this);
