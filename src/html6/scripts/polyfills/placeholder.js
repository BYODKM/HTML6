(function() {
  var blurred, focused, hasOwnAbility, loaded;

  hasOwnAbility = function() {
    var input;
    input = document.createElement('input');
    if ('placeholder' in input) {
      return true;
    } else {
      return false;
    }
  };

  if (hasOwnAbility()) {
    return;
  }

  focused = function() {
    this.setAttribute('data-placeholder', 'false');
    if (this.value === this.getAttribute('placeholder')) {
      this.value = '';
    }
  };

  blurred = function() {
    if (this.value === '') {
      this.value = this.getAttribute('placeholder');
      this.setAttribute('data-placeholder', 'true');
    }
  };

  loaded = function() {
    var i, node, nodes;
    nodes = document.querySelectorAll('[placeholder]');
    for (i = nodes.length - 1; i >= 0; i += -1) {
      node = nodes[i];
      if (node.value === '') {
        node.value = node.getAttribute('placeholder');
        node.setAttribute('data-placeholder', 'true');
      }
      node.addEventListener('focus', focused, false);
      node.addEventListener('blur', blurred, false);
    }
  };

  document.addEventListener('DOMContentLoaded', loaded, false);

}).call(this);
