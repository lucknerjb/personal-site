# config.coffee
# =============

express             = require 'express'
morgan              = require 'morgan'
bodyParser          = require 'body-parser'
cookieParser        = require 'cookie-parser'
methodOverride      = require 'method-override'
path                = require 'path'
swig                = require 'swig'
base_path           = path.dirname require.main.filename
yaml_config         = require 'node-yaml-config'
#local_config        = require base_path + '/config/config.json'
session             = require 'express-session'
redisStore          = require('connect-redis')(session)

module.exports =
  base_path: () ->
    #path.dirname module.parent.filename
    path.dirname require.main.filename

  app_configuration: (app) ->
    return () ->
      # Env?
      env = process.env.NODE_ENV || 'development'
      if 'development' == env
        # General
        app.use bodyParser()

        # Views
        app.engine 'html', swig.renderFile
        app.set 'views', base_path + '/public/views'
        app.set 'view engine', 'html'
        app.use express.static(path.join(base_path, '/public'))
        app.set 'view cache', false # Use Swig's template caching for now
        # Uncomment the following to disable swig's caching
        #swig.setDefaults { cache: false }
        app.use morgan('dev') # log every request to the console
        app.use methodOverride()

        # Session and cookies
        app.use cookieParser('LucknerJB.com Personal Site')
        session_object =
          host: 'localhost',
          port: 6379,
          db: 3,
          key: 'lucknerjb.session.sid'
        app.use(session session_object, 'secret': 'StjU2RhnUuY82ENG8vqrWn3CtyY3ySWyYyE2fLLD29xCf3Wh')
        #app.use express.session()

  load: () ->
    config = yaml_config.load this.base_path() + '/config/config.yml'
    this.config = config
    #console.log this.config

    #this.config = local_config

  all_http_codes: () ->
    codes =
      OK: 200,
      CREATED: 201,
      NO_CONTENT: 204,
      FORBIDDEN: 403,
      NOT_FOUND: 404,
      GONE: 410,
      UNPROCESSABLE_ENTITY: 422,
      TOO_MANY_REQUESTS: 429

  http_code: (type) ->
    codes = this.all_http_codes
    if codes[type] != undefined
      codes[type]
    else
      false

# load config
module.exports.load()

