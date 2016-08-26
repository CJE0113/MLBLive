var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'sportsbook.html';

page.open('https://www.sportsbook.ag/sbk/sportsbook4/tab/live.sbk', function (status) {
  var content = page.content;
  fs.write(path,content,'w');
  phantom.exit();
});