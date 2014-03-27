define ["jquery"], ($) ->

  ARRCookies = document.cookie.split(";")

  crtg_getCookie = (c_name) ->
    i = undefined
    x = undefined
    y = undefined
    i = 0
    while i < ARRCookies.length
      x = ARRCookies[i].substr(0, ARRCookies[i].indexOf("="))
      y = ARRCookies[i].substr(ARRCookies[i].indexOf("=") + 1)
      x = x.replace(/^\s+|\s+$/g, "")
      return unescape(y)  if x is c_name
      i++
    ""

  criteo = ->
    crtg_nid = "1842"
    crtg_cookiename = "cto_trulia"
    crtg_varname = "crtg_content"
    crtg_content = crtg_getCookie(crtg_cookiename)
    crtg_rnd = Math.floor(Math.random() * 99999999999)
    crtg_url = location.protocol + "//rtax.criteo.com/delivery/rta/rta.js?netId=" + escape(crtg_nid)
    crtg_url += "&cookieName=" + escape(crtg_cookiename)
    crtg_url += "&rnd=" + crtg_rnd
    crtg_url += "&varName=" + escape(crtg_varname)
    crtg_script = document.createElement("script")
    crtg_script.type = "text/javascript"
    crtg_script.src = crtg_url
    crtg_script.async = true
    if document.getElementsByTagName("head").length > 0
      document.getElementsByTagName("head")[0].appendChild crtg_script
    else document.getElementsByTagName("body")[0].appendChild crtg_script if document.getElementsByTagName("body").length > 0

  getCriteo = ->
    $.Deferred((deferred_obj) ->
      criteo()
      deferred_obj.resolve()
    ).promise()

  return {
    init: getCriteo
  }