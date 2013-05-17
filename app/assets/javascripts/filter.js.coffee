jQuery ->
  $("#filter").keyup ->
    filter = $(this).val()
    count = 0
    $(".filtered:first li").each ->
      if $(this).text().search(new RegExp(filter, "i")) < 0
        $(this).addClass "hidden"
      else
        $(this).removeClass "hidden"
        count++

    $("#filter-count").text count