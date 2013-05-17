jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  
  $("body").bind "click", (e) ->
    $("a.menu").parent("li").removeClass "open"

  $("a.menu").click (e) ->
    $li = $(this).parent("li").toggleClass("open")
    false