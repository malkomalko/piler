// file: main_coffee_ab7acdd247
(function() {
  var className, gotoAnchor;
  className = "selected";
  gotoAnchor = function() {
    var elem, id;
    id = window.location.hash;
    console.log("adding to", $(id), "removing form", this);
    $("." + className).removeClass(className);
    elem = $(id).next().addClass(className);
    return setTimeout(function() {
      return elem.removeClass(className);
    }, 500);
  };
  $(window).bind("hashchange", gotoAnchor);
  $(document).bind("ready", gotoAnchor);
}).call(this);