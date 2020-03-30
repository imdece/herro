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

app.get('/i2g-status', function (req, res) {
  res.write("OK\n");
  res.end();
});

app.get('/5xx', function(res, req, next){
  res.res.status(500).send("boo :(");;
} );

app.listen(PORT, function () {
  console.log(`Server is listening on port ${PORT}`);
});
