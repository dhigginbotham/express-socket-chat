passport = require "passport"
LocalStrategy = require("passport-local").Strategy

User = require "../app/models/users"

# slower, session based serializing

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done err, user

# this is for serializing/deserializing the 
# user without db lookup... much faster.

# passport.serializeUser (user, done) ->
#   done null, user

# passport.deserializeUser (obj, done) ->
#   done null, obj

passport.use new LocalStrategy (username, password, done) ->
  User.findOne username: new RegExp(username, 'i'), (err, user) ->
    return done err if err
    return done null, false, message: "Unknown user " + username if !user
    user.comparePassword password, (err, isMatch) ->
      return done err if err
      if isMatch
        return done null, user 
      else
        done null, false, message: "Invalid Password"

exports.ensureAuthenticated = ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated()
    return next()
  res.redirect "/login"

exports.ensureAdmin = ensureAdmin = (req, res, next) ->
  if req.user && req.user.admin == true 
    return next() 
  else 
    res.send(403)