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
        confirmButtonText: "Delete",
        closeOnConfirm: false 
      }, ->
        post()
    else
      post()
      
  hljs.initHighlightingOnLoad()

  $(".input-hex").formatter({
    "pattern": "\#{{******}}",
    "persistent": true
  })

  $(".input-date").formatter({
    "pattern": "{{9999}}/{{99}}/{{99}}",
    "persistent": true
  })
  
  # Allow user to click on title
  # and page link to it
  $("h1,h2,h3,h4,h5").each ->
    $this = $(this);
    id = $this.first().text().replace(/\s/,"-")
    $this.attr("id", id)
    
  $("h1,h2,h3,h4,h5").click ->
    $this = $(this)
    id = $this.attr("id")
    if id?
      url = window.location.pathname.replace(/(\/)$/,"")+"#"+id
      window.history.replaceState(null, null, url)
  
  $("blockquote").each ->
    $this = $(this)
    $ps = $this.children()
    numberOfQuotes = $ps.length - 1
    lastQuoteShown = numberOfQuotes
    quoteShown = 0
    animateBlockquote = ->
      if quoteShown > numberOfQuotes
        quoteShown = 0
      $ps.eq(lastQuoteShown).fadeOut 200, ->
        $ps.eq(quoteShown).fadeIn(200)
        lastQuoteShown = quoteShown
        quoteShown = quoteShown + 1
        setTimeout ->
          animateBlockquote()
        , 5000
    if numberOfQuotes > 0
      $ps.hide()
      animateBlockquote()



# ---------------------------------------
#     Run once page content is loaded
# ---------------------------------------
$(window).load ->
  $(".loader").addClass("loaded")  
  $("a").click ->
    $(".loader").removeClass("loaded")