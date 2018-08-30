var express = require('express');
var app = express();

var PORT = process.env.PORT || 3000;
var NAME = process.env.NAME || 'world';
var NODE_ENV = process.env.NODE_ENV || 'xxx';

app.get('/', function (req, res) {
  res.write(`hello ${NAME}!\n\n`);
  res.write(`name: ${NAME}\n`);
  res.write(`port: ${PORT}\n`);
  res.write(`env:  ${NODE_ENV}\n`);
  res.end();
});

app.listen(PORT, function () {
  console.log(`Server is listening on port ${PORT}`);
});
