angular.module("cems.directives").directive "fadeAnimation", ->
  link: (scope, element, attrs) ->
    if attrs.fadeAnimation isnt ""
      scope.$watch attrs.fadeAnimation, (value) ->
        if value is true
          $(element).hide()
          $(element).fadeIn 1000
        else
          $(element).hide()  if attrs.hide isnt "false"
        return

    return
