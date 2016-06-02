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

  CloseFolder = (el) ->
    $(el).find("ul").remove()
    $(el).removeClass "opened"
    $(el).children('.fa').removeClass('fa-folder-open').addClass('fa-folder')
