(function() {
  $(document).ready(function() {
    var url;
    url = window.location;
    $('ul.nav a[href="' + url.pathname + '"]').parent().addClass('active');
    $('ul.nav a').filter(function() {
      return this.href === url.href;
    }).parent().addClass('active');
    return $("form").submit(function(e) {
      e.preventDefault();
      return $.post($(this).attr("action"), $(this).serialize()).success(function(data) {
        data = jQuery.parseJSON(data);
        if (data.redirect) {
          return window.location.href = data.redirect;
        }
      }).fail(function(data) {
        data = jQuery.parseJSON(data.responseText);
        return sweetAlert("Error", data.message, "error");
      });
    });
  });

}).call(this);
