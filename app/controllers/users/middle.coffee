User = require "../../models/users"

_users = module.exports =
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

    Object.create user =
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
    if !req.form.isValid
      req.flash "info", type: "error", title: "Oh Snap!", msg: req.form.errors
      next()

    user = new User
      username: req.body.username        
      ip: req.ip     
      first_name: req.body.first_name        
      last_name: req.body.last_name
      email: req.body.email
      admin: false

    user.save (err, user) ->
      if err
        req.flash "info", type: "error", title: "Oh Snap!", msg: "wasn't able to create"
        next()
      if user
        req.flash "info", type: "success", title: "Sweet!", msg: "You've been updated"
        next()