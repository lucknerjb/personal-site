// Generated by CoffeeScript 1.7.1
var base_path, bodyParser, cookieParser, express, methodOverride, morgan, path, redisStore, session, swig, yaml_config;

express = require('express');

morgan = require('morgan');

bodyParser = require('body-parser');

cookieParser = require('cookie-parser');

methodOverride = require('method-override');

path = require('path');

swig = require('swig');

base_path = path.dirname(require.main.filename);

yaml_config = require('node-yaml-config');

session = require('express-session');

redisStore = require('connect-redis')(session);

module.exports = {
  base_path: function() {
    return path.dirname(require.main.filename);
  },
  app_configuration: function(app) {
    return function() {
      var env, session_object;
      env = process.env.NODE_ENV || 'development';
      if ('development' === env) {
        app.use(bodyParser());
        app.engine('html', swig.renderFile);
        app.set('views', base_path + '/public/views');
        app.set('view engine', 'html');
        app.use(express["static"](path.join(base_path, '/public')));
        app.set('view cache', false);
        swig.setDefaults({
          cache: false
        });
        app.use(morgan('dev'));
        app.use(methodOverride());
        app.use(cookieParser('LucknerJB.com Personal Site'));
        session_object = {
          host: 'localhost',
          port: 6379,
          db: 3,
          key: 'lucknerjb.session.sid'
        };
        return app.use(session(session_object, {
          'secret': 'StjU2RhnUuY82ENG8vqrWn3CtyY3ySWyYyE2fLLD29xCf3Wh'
        }));
      } else {
        return swig.setDefaults({
          cache: true
        });
      }
    };
  },
  load: function() {
    var config;
    config = yaml_config.load(this.base_path() + '/config/config.yml');
    return this.config = config;
  },
  all_http_codes: function() {
    var codes;
    return codes = {
      OK: 200,
      CREATED: 201,
      NO_CONTENT: 204,
      FORBIDDEN: 403,
      NOT_FOUND: 404,
      GONE: 410,
      UNPROCESSABLE_ENTITY: 422,
      TOO_MANY_REQUESTS: 429
    };
  },
  http_code: function(type) {
    var codes;
    codes = this.all_http_codes;
    if (codes[type] !== void 0) {
      return codes[type];
    } else {
      return false;
    }
  }
};

module.exports.load();
