# tools.coffee
# ============

config = require './config'

module.exports =
  config: () ->
    config()

  connection: () ->
    # Stub out connection
    return

  createSlug: (string) ->
    # Replace all spaces with a dash
    string.toLowerCase().replace /\s/g, '-'

    # Replace anything not a alphanum or dash with nothing
    string.replace /[^\w-]+/g, ''