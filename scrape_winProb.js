var webPage = require('webpage');
var page = webPage.create();

var fs = require('fs');
var path = 'fangraphs.html';

page.open('http://www.fangraphs.com/liveplays.aspx?date=2016-08-14&team=Giants&dh=0&season=2016', function (status) {
  var content = page.content;
  fs.write(path,content,'w');
  phantom.exit();
});