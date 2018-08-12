var express = require('express');
var app = express();

var PORT = process.env.PORT || 80;
var NAME = process.env.NAME || 'world';

app.get('/', function (req, res) {
  res.send(`hello ${NAME}!`);
});

app.listen(PORT, function () {
  console.log(`Server is listening on port ${PORT}`);
});
