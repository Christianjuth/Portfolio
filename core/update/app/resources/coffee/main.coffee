# ---------------------------------------
#       Run once the DOM is loaded
# ---------------------------------------
$(document).ready ->
  url = window.location

  # Will only work if string in href matches with location
  $("ul.nav a[href='" + url.pathname + "']").parent().addClass("active")

  # Will also work for relative and absolute hrefs
  $("ul.nav a").filter ->
    this.href == url.href
  .parent().addClass("active")

  # Interupt form
  $("form").submit (e)->
    e.preventDefault()
    $this = $(this)
    formData = new FormData($this[0])
    $.ajax({
      url: $this.attr("action")
      type: $this.attr("method")
      data: formData
      async: false
      cache: false
      contentType: false
      processData: false
      success: (data)->
        data = jQuery.parseJSON(data)
        # data.redirect contains the string URL to redirect to
        if (data.redirect)
          window.location.href = data.redirect
      error: (data)->
        data = jQuery.parseJSON(data.responseText)
        sweetAlert("Error", data.message, "error")
    })

  $("input:file").change ()->
    $(this).closest("form").submit()
  
  $("select[default]").each ->
    $(this).val($(this).attr("default"))
    
  $("a[type=fake_submit]").click (e)->
    e.preventDefault()
    $this = $(this)
    post = ->
      $.post($this.attr("action"))
      .success (data)->
        data = jQuery.parseJSON(data)
        # data.redirect contains the string URL to redirect to
        if (data.redirect)
          window.location.href = data.redirect
      .fail (data)->
        data = jQuery.parseJSON(data.responseText)
        sweetAlert("Error", data.message, "error")
    $this = $(this)
    if $this.hasClass("delete")
      sweetAlert {   
        title: "Are you sure?",   
        type: "warning",
        showCancelButton: true, 
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Confirm Delete",
        closeOnConfirm: false 
      }, ->
        post()
    else
      post()
      
  $(".btn").not(".btn-link").addClass("ripple");

  if $().formatter
    $(".input-hex").formatter({
      "pattern": "\#{{******}}",
      "persistent": true
    })

    $(".input-date").formatter({
      "pattern": "{{99}}/{{99}}/{{9999}}",
      "persistent": true
    })

    $(".input-phone").formatter({
      "pattern": "{{9}}-({{999}})-{{999}}-{{9999}}",
      "persistent": true
    })
      
  $(".inline-form").each ->
    $this = $(this)
    timeout = 0
    $this.find("input, textarea").focusout ->
      timeout = setTimeout( ->
        $this.find(".inline-delete").show()
        $this.find(".inline-update").addClass("hidden")
      , 300)
    $this.find("input, textarea").focusin ->
      clearTimeout(timeout)
      $this.find(".inline-delete").hide()
      $this.find(".inline-update").removeClass("hidden")
    $this.find(".inline-update").click ->
      clearTimeout(timeout)
      $this.find(".inline-delete").hide()
      $this.find(".inline-update").removeClass("hidden")


# ---------------------------------------
#     Run once page content is loaded
# ---------------------------------------
$(window).load ->
  $(".loader").addClass("loaded")  
    
  saveScroll = ->
    localStorage.scrollTop = $(window).scrollTop() + ""
    localStorage.scrollPath = window.location.pathname
  updateScroll = ->
    if location.hash != ""
      setTimeout ->
        $(window).scrollTop($(location.hash).offset().top)
      , 1
    else if window.location.pathname == localStorage.scrollPath
      $(window).scrollTop(localStorage.scrollTop)
  $(window).scroll ->
    saveScroll()
  updateScroll()