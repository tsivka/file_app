  $(document).on "click", ".open-folder", (e)->
    e.stopPropagation()
    el = $(this)
    if $(el).hasClass('opened')
        CloseFolder(el);
        return;

    $.ajax
      url: "folder/content"
      type: "POST"
      data:
        _methot: "POST"
        paths: $(this).data('path')

      success: (response) ->
        $(el).addClass 'opened'
        $(el).append response
        $(el).children('.fa').addClass('fa-folder-open').removeClass('fa-folder')

  $(document).on "click", ".open-file", (e)->
    e.stopPropagation()
    el = $(this)
    if $(el).hasClass('opened')
      return;

    $.ajax
      url: "folder/show_file"
      type: "POST"
      data:
        _methot: "POST"
        paths: $(this).data('path')

      success: (response) ->
        $('.file-area').show().val response


  $(document).on "click", ".js-create", ()->
    $('.file-name').val('').show()
    $('.file-area').val('').show()
    $(this).hide()
    $('.js-save').show()
    $(".js-save").attr("disabled", true)


  $(document).on "click", ".js-save", ()->
      if( $('.file-name').val().length==0)
        return
      if($('.file-area').val().length==0)
        confirm('Do you want to create empty file')

      $.ajax
      url: "folder/create_file"
      type: "POST"
      data:
        _methot: "POST"
        path: $('.folder-path').text()+'/'+$('.file-name').val()
        content: $('.file-area').val()
      success: (response) ->
        $('.file-area').val response


  CloseFolder = (el) ->
    $(el).find("ul").remove()
    $(el).removeClass "opened"
    $(el).children('.fa').removeClass('fa-folder-open').addClass('fa-folder')
