define ['jquery'], ($) ->

  ARRCookies      = document.cookie.split(';')
  CRTG_NID        = '1842'
  CRTG_VARNAME    = 'crtg_content'
  CRTG_COOKIENAME = 'cto_trulia'
  CRTG_URI        = "#{window.location.protocol}//rtax.criteo.com/delivery/rta/rta.js"

  crtgGetCookie = ->
    x = y = undefined
    i = 0
    while i < ARRCookies.length
      x = ARRCookies[i].substr(0, ARRCookies[i].indexOf('='))
      y = ARRCookies[i].substr(ARRCookies[i].indexOf('=') + 1)
      x = x.replace(/^\s+|\s+$/g, '')
      return unescape(y)  if x is CRTG_COOKIENAME
      i++
    ''

  criteoScript = ->
    window.crtg_content = crtgGetCookie()
    appendTag(scriptTag())

  scriptTag = ->
    crtg_script = document.createElement('script')
    crtg_script.type  = 'text/javascript'
    crtg_script.src   = criteoUrl()
    crtg_script.async = true
    crtg_script

  criteoUrl = ->
    crtg_url =  "#{CRTG_URI}?netId=#{CRTG_NID}"
    crtg_url += "&cookieName=#{CRTG_COOKIENAME}"
    crtg_url += "&varName#{CRTG_VARNAME}"
    crtg_url

  appendTag = (script) ->
    if document.getElementsByTagName('head').length > 0
      document.getElementsByTagName('head')[0].appendChild script
    if document.getElementsByTagName('body').length > 0
      document.getElementsByTagName('body')[0].appendChild script

  getCriteo = ->
    $.Deferred((deferredObj) ->
      criteoScript()
      deferredObj.resolve()
    ).promise()

  return {
    init: getCriteo
  }
