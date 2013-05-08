mongoose = require "mongoose"
mongoose.set "debug", true if process.env.NODE_ENV == "development"

DB_CONNECTION_STRING = process.env.DB_STRING || "mongodb://localhost/chat"
db = global.db = mongoose.createConnection(DB_CONNECTION_STRING);
db.on "error", console.error.bind console, "connection error:"
