NavLoader = module.exports =
  types:
    auth: [
      {std : null, id : 'welcome', icon : 'home', cur : null, href : '/', token : null}
      {std : 'Logout', id : 'logout', icon : null, cur : null, href : '/logout', token : null}
      {std : 'Chat', id : 'chat', icon : null, cur : null, href : '/a/chat', token : null}
      {std : 'Account', id : 'account', icon : null, cur : null, href : '/users/edit', token : null}
    ]

    noauth: [
      {std : null, id : 'home', icon : 'home', cur : null, href : '/', token : null}
      {std : 'Login', id : 'login', icon : null, cur : null, href : '/login', token : null}
      {std : 'Register', id : 'register', icon : null, cur : null, href : '/register', token : null}
    ]

    admin: [
      {std : null, id : 'welcome', icon : 'home', cur : null, href : '/', token : null}
      {std : 'Chat', id : 'chat', icon : null, cur : null, href : '/a/chat', token : null}
      {std : 'Secret Society', id : 'ss-chat', icon : null, cur : null, href : '/secret-society/chat', token : null}
      {std : 'Accounts', id : 'accounts', icon : null, cur : null, href : '/users/view', token : null}
      {std : 'Logout', id : 'logout', icon : null, cur : null, href : '/logout', token : null}
    ]

  render: (req, res, next) ->

    if !req.user
      nav = NavLoader.types.noauth
    else if req.user.admin is true
      nav = NavLoader.types.admin
    else
      nav = NavLoader.types.auth

    for n in nav
      do (n) ->
        if req.route.path == n.href
          n.cur = "active"
        else
          n.cur = null

    process.nextTick () ->
      req.Navigation = nav
      next()

