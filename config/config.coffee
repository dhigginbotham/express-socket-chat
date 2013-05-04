config = module.exports =
  defaults: (req, res, next) ->
    Object.create app =
      name: "RTF"
      page: req.url
      ip: req.connection.remoteAddress
    req.Config = app
    next()