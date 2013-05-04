scripts = module.exports =
  items: [
    {src: '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js', name: 'jquery.js', where: 'head', uri: null, type: 'js'}
    {src: '//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js', name: 'bootstrap.js', where: 'head', uri: null, type: 'js'}
    {src: '//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-combined.no-icons.min.css', name: 'bootstrap.css', where: 'head', uri: null, type: 'css'}
    {src: '//netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css', name: 'font-awesome.css', where: 'head', uri: null, type: 'css'}
    {src: '/css/login.css', name: 'login.css', where: 'head', uri: '/login', type: 'css'}
    {src: '/css/style.css', name: 'style.css', where: 'head', uri: null, type: 'css'}
    {src: '/socket.io/socket.io.js', name: 'socket.io.js', where: 'head', uri: null, type: 'js'}
    {src: '/js/jquery.jqBootstrapValidation.js', name: 'jquery.jqBootstrapValidation.js', where: 'head', uri: null, type: 'js'}
    {src: '/js/helpers.client.js', name: 'helpers.client.js', where: 'foot', uri: null, type: 'js'}
    {src: '/js/scripts.client.js', name: 'scripts.client.js', where: 'foot', uri: null, type: 'js'}
    {src: '/js/chatbox.client.js', name: 'chatbox.client.js', where: 'foot', uri: null, type: 'js'}
    {src: '/js/priv.client.js', name: 'priv.client.js', where: 'foot', uri: '/secret-society/chat', type: 'js'}
    {src: '/js/pub.client.js', name: 'pub.client.js', where: 'foot', uri: '/a/chat', type: 'js'}
    {src: '/css/emojify.min.css', name: 'emojify.min.css', where: 'head', uri: '/a/chat', type: 'css'}
    {src: '/css/emojify.min.css', name: 'emojify.min.css', where: 'head', uri: '/secret-society/chat', type: 'css'}
  ]

  embed: (req, res, next) ->

    script = scripts.items

    Object.create embed =
      head:
        js: []
        css: []
      foot:
        js: []
        css: []

    for ctx in script
      do (ctx) ->
        if embed.head[ctx.type] || embed.foot[ctx.type]
          if ctx.uri == req.route.path || ctx.uri == null
            console.log "pushing #{ctx.name} into #{ctx.where}er" if process.env.NODE_ENV is "development"
            embed[ctx.where][ctx.type].push ctx

    process.nextTick () ->
      req.Embed = embed
      next()
