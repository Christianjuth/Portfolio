$(document).ready ->
  index = client.initIndex('standards')
  searchTimeoutId = null
  $(".search").focus()
  $(".search").keydown ->
    clearTimeout(searchTimeoutId)
    $this = $(this)
    searchTimeoutId = setTimeout ->
      search = $this.val()
      highlightSearch = new RegExp("(" + search + ")", "ig");
      if search.replace(/\s*/, "") == ""
        $(".search-results table").empty()
      else
        index.search(search, (err, content)->
          results = ""
          content.hits.forEach (hit)->
            results += """
              <tr>
                <td>#{hit.title.replace(highlightSearch, "<b>$1</b>")}</td>
                <td class="text-right">#{hit.height} x #{hit.width}</td>
                <td class="text-right hidden-xs">#{reduce(hit.height,hit.width).join(":")}</td>
              </tr>
            """
          $(".search-results table").empty()
          $(results).appendTo(".search-results table");
      )
    , 1200
  
  
  reduce = (numerator,denominator)->
    gcd = (a,b)->
      if b 
        gcd(b, a%b) 
      else
        a
    gcd = gcd(numerator,denominator)
    [numerator/gcd, denominator/gcd]
