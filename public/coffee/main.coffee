# ---------------------------------------
#       Run once the dom is loaded
# ---------------------------------------
$(document).ready ->
  url = window.location

  # Will only work if string in href matches with location
  $('ul.nav a[href="' + url.pathname + '"]').parent().addClass('active')

  # Will also work for relative and absolute hrefs
  $('ul.nav a').filter ->
    this.href == url.href
  .parent().addClass('active')

  # Interupt form
  $("form").submit (e)->
    e.preventDefault()
    $.post($(this).attr("action"), $(this).serialize())
    .success (data)->
      data = jQuery.parseJSON(data)
      # data.redirect contains the string URL to redirect to
      if (data.redirect)
        window.location.href = data.redirect
    .fail (data)->
      data = jQuery.parseJSON(data.responseText)
      sweetAlert("Error", data.message, "error")
  
  $("select[default]").each ->
    $(this).val($(this).attr("default"))
    
  $("a[type=fake_submit]").click ->
    $.post($(this).attr("action"))
    .success (data)->
      data = jQuery.parseJSON(data)
      # data.redirect contains the string URL to redirect to
      if (data.redirect)
        window.location.href = data.redirect
    .fail (data)->
      data = jQuery.parseJSON(data.responseText)
      sweetAlert("Error", data.message, "error")
      
  hljs.initHighlightingOnLoad()

  $(".input-hex").formatter({
    'pattern': '#{{******}}',
    'persistent': true
  })

  $(".input-date").formatter({
    'pattern': '{{9999}}/{{99}}/{{99}}',
    'persistent': true
  })
  
  
# ---------------------------------------
# Hide loader once page content is loaded
# ---------------------------------------
$(window).load ->
  $('.loader').addClass('loaded')
  
  $("a").click ->
    $('.loader').removeClass('loaded')