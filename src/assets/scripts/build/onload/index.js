(function() {
  var loaded;

  loaded = function() {
    var scope;
    scope = document.getElementById('page--index');
    if (!scope) {
      return;
    }
    (function() {})();
  };

  document.addEventListener('DOMContentLoaded', loaded, false);

}).call(this);
