passport = require "passport"
FacebookStrategy = require("passport-facebook").Strategy

# require user schema
User = require "../app/models/users"

if process.env.NODE_ENV == "development"
  FACEBOOK_APP_ID = "456946017732211"
  FACEBOOK_APP_SECRET = "47436dae949615733ac56357b5572d45"

if process.env.NODE_ENV is "development"
  redirect_url = "http://localhost:3100"

passport.use new FacebookStrategy
  clientID: FACEBOOK_APP_ID
  clientSecret: FACEBOOK_APP_SECRET
  callbackURL: "#{redirect_url}/auth/facebook/callback"
  scope: "email, user_location, user_likes, publish_actions"
  (accessToken, refreshToken, profile, done) ->
    User.findOne email: profile._json.email, (err, user) ->
      if err
        return done err, null 
      if user
        Object.create updateUser =
          updated: new Date profile._json.updated_time
          token: accessToken

        User.update username: profile._json.username, updateUser, (err) ->
          if err
            return done err, null 

          process.nextTick () ->
            return done null, user
      else
        user = new User
          username: profile._json.username
          token: accessToken
          first_name: profile._json.first_name
          last_name: profile._json.last_name
          email: profile._json.email
          location: profile._json.location
          role: "facebook"
        
        user.save (err, newUser) ->
          if err
            return done err, null 
          if newUser
            return done null, newUser
            