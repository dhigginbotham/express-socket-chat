mongoose = require('mongoose');
paginate = require('paginate')({
    mongoose: mongoose
});

Chat = require "../../models/chat"

chat = module.exports =
  FindPublicChatHistory: (req, res, next) ->
    
    if req.url == "/a/chat"
      sort = {date: 1}
    
    if req.route.path == "/a/history/:page"
      sort = {date: -1}

    query =
      room: "pub"

    Chat
      .find(query)
      .sort(sort)
      .paginate {page: req.params.page, perPage: 30}, (err, docs) ->
        if err
          req.flash "info", type: "error", title: "Oh Snap!", msg: "wasn't able to find any chats"
          next()
        else
          req.pubChatHistory = docs
          next()

  FindPrivateChatHistory: (req, res, next) ->
    
    if req.url == "/a/secret-society"
      sort = {date: 1}
    
    if req.route.path == "/a/secret-society/:page"
      sort = {date: -1}

    query =
      room: "priv"

    Chat
      .find(query)
      .sort({date: -1})
      .paginate {page: req.params.page, perPage: 30}, (err, docs) ->
        if err
          req.flash "info", type: "error", title: "Oh Snap!", msg: "wasn't able to find any chats"
          next()
        else
          req.privChatHistory = docs
          next()
  FindLatestChatHistory: (req, res, next) ->
    
    if req.url == "/a/chat"
      sort = {date: 1}
    
    if req.route.path == "/a/history/:page"
      sort = {date: -1}

    query =
      room: "pub"

    Chat
      .find(query)
      .sort({date: -1})
      .limit 30, (err, docs) ->
        if err
          req.flash "info", type: "error", title: "Oh Snap!", msg: "wasn't able to find any chats"
          next()
        else
          req.pubChatHistory = docs
          next()