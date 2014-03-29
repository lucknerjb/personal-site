tools   = require '../tools'
config  = require '../config'

exports.index = (req, res) ->
    res.render('index', {title: 'Express'})
