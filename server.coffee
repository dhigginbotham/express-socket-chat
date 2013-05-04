express = require "express"
app = express()
flash = require "connect-flash"
server = require("http").createServer(app)
io = require("socket.io").listen(server)

# socket.io xdomain enforcement
io.configure () ->
  io.set "authorization", (handshakeData, callback) ->
    if handshakeData.xdomain 
      callback "Cross-domain connections are not allowed"
    else callback null, true

io.configure "production", () ->
  io.enable "browser client minification"
  io.enable "browser client etag"
  io.enable "browser client gzip"
  io.set "transports", ['websocket', 'jsonp-polling']
  io.set "log level", 1

io.configure "development", () ->
  io.set "transports", ['websocket', 'jsonp-polling']

fs = require "fs"
path = require "path"

# global connection sharing
shared_db = require "./app/models/db"

# config middleware & methods 
config = require "./config/config"
scripts = require "./config/scripts"
nav = require "./config/nav"

# passport auth middleware
pass = require "./config/pass"
pass_facebook = require "./config/pass.facebook"
passport = require "passport"

# controllers & routes
auth_controllers = require "./app/controllers/auth"
users_controllers = require "./app/controllers/users"
main_controllers = require "./app/controllers/main"
chat_controllers = require "./app/controllers/chat"

# route validation middleware
users_validate = require "./app/models/users/validate" 

# route middleware
auth_middle = require "./app/controllers/auth/middle"
users_middle = require "./app/controllers/users/middle"

# default configuration settings
app.configure () ->
  app.set "port", process.env.port
  app.set "views", "./app/views"
  app.set "view engine", "mmm"
  app.set "layout", "layout"
  app.use express.compress()
  app.use express.logger "dev"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  # using cooking sessions to improve overall speed
  app.use express.cookieSession
    secret: "cookie-secret"
    cookie:
      maxAge: 60 * 60 * 1000
  app.use passport.initialize()
  app.use passport.session()
  app.use flash()
  # app.use config.defaults
  app.use app.router
  app.use express.static path.join __dirname, "public"

app.configure "production", () ->
  app.use express.errorHandler()
  # this is caching, its our friend :)
  # app.use (req, res, next) ->
  #   if req.url.indexOf "/js/" == 0 && req.url.indexOf "/img/" == 0
  #     res.setHeader "Cache-Control", "public, max-age=345600"
  #     res.setHeader "Expires", new Date(Date.now() + 345600000).toUTCString()
  #     next()

app.configure "development", () ->
  app.set "port", 3100
  app.use express.errorHandler 
    dumpExceptions: true
    showStack: true

# default routes
app.get "/", scripts.embed, nav.render, main_controllers.get.home

# user routes
app.get "/login", scripts.embed, nav.render, auth_controllers.get.login
app.post "/login",
  passport.authenticate "local",
    failureRedirect: "/login#failed-login" 
    failureFlash: false
  (req, res, done) -> 
    return res.redirect "/"

app.get "/a/chat", pass.ensureAuthenticated, scripts.embed, nav.render, chat_controllers.get.public
app.get "/secret-society/chat", pass.ensureAuthenticated, pass.ensureAdmin, scripts.embed, nav.render, chat_controllers.get.private

app.get "/logout", pass.ensureAuthenticated, auth_controllers.get.logout
app.get "/register", scripts.embed, nav.render, users_controllers.get.register

app.post "/register", users_validate.register, users_middle.Create, users_controllers.post.register

# passport-facebook routes
app.get "/auth/facebook", passport.authenticate("facebook"), (req, res) ->
app.get "/auth/facebook/callback", passport.authenticate("facebook", failureRedirect: "/login"), (req, res) ->
  res.redirect "/"

usernames = {}
pUsernames = {}

priv = io
  .of("/priv")
  .on "connection", (socket) ->

    socket.on "sendchat", (data) ->
      if data.length > 1 && data.length < 600
        priv.emit "updatechat", socket.username, data

    .on "adduser", (username) ->
      console.log pUsernames
      if username == pUsernames[username] || !username
        delete pUsernames[socket.username]
      socket.username = username
      pUsernames[username] = username
      priv.emit "updateusers", pUsernames

    .on "disconnect", () ->
      delete pUsernames[socket.username]
      priv.emit "updateusers", pUsernames

pub = io
  .of("/pub")
  .on "connection", (socket) ->

    socket.on "sendchat", (data) ->
      if data.length > 1 && data.length < 600
        pub.emit "updatechat", socket.username, data

    .on "adduser", (username) ->
      console.log usernames
      if username == usernames[username] || !username
        delete usernames[socket.username]
      socket.username = username
      usernames[username] = username
      pub.emit "updateusers", usernames

    .on "disconnect",() ->
      delete usernames[socket.username]
      pub.emit "updateusers", usernames

server.listen app.get("port"), () ->
  console.log "Express server listening on port #{app.get("port")} in #{app.settings.env} mode"
