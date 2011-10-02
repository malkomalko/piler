// exec: 33a05517ec
(function () {
    return console.log("Hello github pages!");
  })();


// object: 9cd3690b0c
window['PILE'] = {"incUrlSeq": function (url) {
    var cleanUrl, match, seq, seqRegexp;
    seqRegexp = /--([0-9]+)$/;
    match = url.match(seqRegexp);
    seq = parseInt((match != null ? match[1] : void 0) || 0, 10);
    cleanUrl = url.replace(seqRegexp, "");
    return cleanUrl + ("--" + (seq + 1));
  }};


// exec: c409261c9f
(function () {
    var pile;
    console.log("CSS updater is active. Waiting for connection...");
    pile = io.connect('/pile');
    pile.on("connect", function() {
      return console.log("CSS updater has connected");
    });
    pile.on("disconnect", function() {
      return console.log("CSS updater has disconnected! Refresh to reconnect");
    });
    return pile.on("update", function(fileId) {
      var elem;
      elem = document.getElementById("pile-" + fileId);
      if (elem) {
        console.log("updating", fileId, elem);
        return elem.href = PILE.incUrlSeq(elem.href);
      } else {
        return console.log("id", fileId, "not found");
      }
    });
  })();