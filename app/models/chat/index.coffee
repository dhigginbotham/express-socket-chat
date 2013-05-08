string = require "../../../helpers"
moment = require "moment"

Schema = require("mongoose").Schema
ObjectId = Schema.Types.ObjectId

ChatSchema = new Schema
  who:
    type: String
  message: String
  date:
    type: Date
    default: Date.now
  ip: String
  room: String

Chat = module.exports = db.model "Chat", ChatSchema

ChatSchema.statics.prepareHistory = prepareHistory = (chat) ->
  chat['page-count'] = chat.pagination.pages.length
  chat['created-date-from-now'] = moment(new Date(chat.date)).fromNow()
  chat['chat-id'] = chat._id
  chat['pretty-time'] = moment(new Date(chat.date)).format "h:mmA"
  chat['pretty-date'] = moment(new Date(chat.date)).format "M/D/YY"