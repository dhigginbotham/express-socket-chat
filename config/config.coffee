config = module.exports =
  defaults: (req, res, next) ->
    Object.create app =
      name: "Watch Chat"
      page: req.url
      user: req.user || false
      ip: req.connection.remoteAddress
    req.Config = app
    next()