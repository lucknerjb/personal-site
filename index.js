// Generated by CoffeeScript 1.7.1
var app, config, express, http, md5, path, port, swig, tools, url, _;

express = require('express');

http = require('http');

path = require('path');

url = require('url');

swig = require('swig');

md5 = require('md5');

_ = require('underscore');

app = express();

tools = require('./libs/tools');

config = require('./libs/config');

port = process.env.PORT || 3000;

config.app_configuration(app)();

app.use(function(req, res, next) {
  var err, msg;
  err = req.session.error;
  msg = req.session.success;
  delete req.session.error;
  delete req.session.success;
  res.locals.message = '';
  if (err) {
    res.locals.message = '<p class="msg error">' + err + '</p>';
  }
  if (msg) {
    res.locals.message = '<p class="msg success">' + msg + '</p>';
  }
  return next();
});

app.listen(port);

app.get('/', function(req, res, next) {
  return res.send('Welcome!');
});

http.createServer(app).listen(app.get('port'), function() {
  return console.log('Express Server listening on port: ' + port);
});
