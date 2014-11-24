(function() {
  var loaded;

  loaded = function() {
    (function() {})();
  };

  document.addEventListener('DOMContentLoaded', loaded, false);

}).call(this);
