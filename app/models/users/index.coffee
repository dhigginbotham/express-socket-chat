string = require "../../../helpers"

Schema = require("mongoose").Schema
ObjectId = Schema.Types.ObjectId

bcrypt = require "bcrypt"
SALT_WORK_FACTOR = 10

UserSchema = new Schema
  username:
    type: String
    unique: true
    required: true
  password:
    type: String
  email:
    type: String
    required: true
  admin: 
    type: Boolean
    default: false
  created: 
    type: Date
    default: Date.now
  ip: String
  first_name: String
  last_name: String
  token: String
  page: String
  updated: 
    type: Date
    default: Date.now

UserSchema.pre "save", (next) ->
  user = this

  if !user.isModified "password"
    return next()
  else
    bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
      if err
        return next(err)
      bcrypt.hash user.password, salt, (err, hash) ->
        if err
          return next(err)
        else
          user.password = hash
          return next()

UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, this.password, (err, isMatch) ->
    if err
      return cb(err)
    cb null, isMatch

User = module.exports = db.model "User", UserSchema

if process.env.NODE_PASS
  db.once "open", () ->
    User.findOne 
      username: "admin", (err, docs) ->
        return err if err
        if !docs
          admin = new User
            username: "admin"
            password: process.env.NODE_PASS || "passw0rd"
            admin: true
            email: "admin@localhost.dev"
            ip: "admin.ipv6"

          admin.save (err) ->
            return err if err

