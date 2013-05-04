User = require "../../models/users"

users = module.exports =
  Update: (req, res, next) ->

    if req.user || req.url =="/users/edit"
      query = req.user.username
    else
      query = req.params.user
    
    if !req.body.is_admin
      admin = false
    else if !req.user.admin
      admin = false
    else 
      admin = true

    user =
      ip: req.ip     
      first_name: req.body.first_name
      last_name: req.body.last_name
      email: req.body.email
      admin: admin

    User.update username: query, user, (err) ->
      if err
        req.flash "info", type: "error", title: "Oh Snap!", msg: "wasn't able to update"
        next()
      else
        req.flash "info", type: "success", title: "Sweet!", msg: "You've been updated"
        next()

  Create: (req, res, next) ->
    User.findOne username: req.body.username, (err, usr) ->
      return next() if err
      if !usr
        user = new User
          username: req.body.username        
          password: req.body.password        
          ip: req.ip     
          first_name: req.body.first_name        
          last_name: req.body.last_name
          email: req.body.email
          admin: false

        user.save (err) ->
          if err
            req.flash "info", type: "error", title: "Oh Snap!", msg: "wasn't able to create"
            next()
          else
            req.flash "info", type: "success", title: "Sweet!", msg: "You've been updated"
            next()

      process.nextTick () ->
        next()

  FindAll: (req, res, next) ->
    User.find {}, password: 0, _id: 0, __v: 0, created: 0, (err, docs) ->
      return err if err
      req.findAll = docs
      next()

  FindSelf: (req, res, next) ->
    User.findOne username: req.user.username, (err, user) ->
      if err
        req.flash "info", type: "error", title: "Sorry", msg: "we weren't able to locate your user document.."
        next()
      if user      
        req.FindSelf = user
        next()

  FindByParam: (req, res, next) ->
    User.findOne username: req.params.user, (err, user) ->
      if err
        req.flash "info", type: "error", title: "Sorry", msg: "we weren't able to locate your user document.."
        next()
      if user
        req.FindByParam = user
        next()
