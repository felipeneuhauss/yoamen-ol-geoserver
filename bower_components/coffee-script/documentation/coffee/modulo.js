// Generated by CoffeeScript 1.10.0
(function() {
  var modulo = function(a, b) { return (+a % (b = +b) + b) % b; };

  -7 % 5 === -2;

  modulo(-7, 5) === 3;

  tabs.selectTabAtIndex(modulo(tabs.currentIndex - count, tabs.length));

}).call(this);

//# sourceMappingURL=modulo.js.map