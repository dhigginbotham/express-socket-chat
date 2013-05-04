NavLoader = module.exports =
  types:
    auth: [
      {std : null, id : 'welcome', icon : 'home', cur : null, href : '/', token : null},
      {std : 'Logout', id : 'logout', icon : null, cur : null, href : '/logout', token : null}
    ]

    noauth: [
      {std : null, id : 'home', icon : 'home', cur : null, href : '/', token : null},
      {std : 'Login', id : 'login', icon : null, cur : null, href : '/login', token : null},
      {std : 'Register', id : 'register', icon : null, cur : null, href : '/register', token : null}
    ]

    admin: [
      {std : null, id : 'welcome', icon : 'home', cur : null, href : '/', token : null},
      {std : 'Logout', id : 'logout', icon : null, cur : null, href : '/logout', token : null}
    ]

  render: (req, res, next) ->

    if !req.user
      nav = NavLoader.types.noauth
    else if req.user.admin is true
      nav = NavLoader.types.auth
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

