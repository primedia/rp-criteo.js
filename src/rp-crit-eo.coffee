define ["jquery"], ($) ->

  criteo = ->
    `
    var crtg_nid="1842";
    var crtg_cookiename="cto_trulia";
    var crtg_varname="crtg_content";
    function crtg_getCookie(c_name){ var i,x,y,ARRCookies=document.cookie.split(";");for(i=0;i<ARRCookies.length;i++){x=ARRCookies[i].substr(0,ARRCookies[i].indexOf("="));y=ARRCookies[i].substr(ARRCookies[i].indexOf("=")+1);x=x.replace(/^\s+|\s+$/g,"");if(x==c_name){return unescape(y);}}return'';}

    // This is the only RP change from Criteo
    window.crtg_content = crtg_getCookie(crtg_cookiename);var crtg_rnd=Math.floor(Math.random()*99999999999);

    var crtg_url=location.protocol+'//rtax.criteo.com/delivery/rta/rta.js?netId='+escape(crtg_nid);crtg_url+='&cookieName='+escape(crtg_cookiename);crtg_url+='&rnd='+crtg_rnd;crtg_url+='&varName=' + escape(crtg_varname);
    var crtg_script=document.createElement('script');crtg_script.type='text/javascript';crtg_script.src=crtg_url;crtg_script.async=true;
    if(document.getElementsByTagName("head").length>0)document.getElementsByTagName("head")[0].appendChild(crtg_script);else if(document.getElementsByTagName("body").length>0)document.getElementsByTagName("body")[0].appendChild(crtg_script);
    `
    '' # So CoffeeScript doesn't return var from line 5

  getCriteo = ->
    $.Deferred((deferred_obj) ->
      criteo()
      deferred_obj.resolve()
    ).promise()

  return {
    init: getCriteo
  }
