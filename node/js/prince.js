var express = require('express');
var app = express();

app.get('/BC-1',(req, res) => {
  res.send('Hello Express');
});

app.get('/',(req, res) => {
  res.send('Hellooo');
});

app.listen(4000,() => {
  console.log("Server started");
});
