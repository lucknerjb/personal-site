express = require 'express'
http    = require 'http'
path    = require 'path'
url     = require 'url'
swig    = require 'swig'
md5     = require 'md5'
_       = require 'underscore'

app     = express()
tools   = require './libs/tools'
config  = require './libs/config'

#routes  = require 'routes'
port    = process.env.PORT || 3000

# Setup application configuration
config.app_configuration(app)()

# Helpers for messages
app.use (req, res, next) ->
  err = req.session.error
  msg = req.session.success
  delete req.session.error
  delete req.session.success
  res.locals.message = ''
  res.locals.message = '<p class="msg error">' + err + '</p>' if err
  res.locals.message = '<p class="msg success">' + msg + '</p>' if msg
  next()

# Local port to listen to
app.listen port

app.get(
  '/', (req, res, next) ->
    res.send 'Welcome!'
)

# Create server
http.createServer(app).listen(
  app.get('port'),
  () ->
    console.log 'Express Server listening on port: ' + port
)