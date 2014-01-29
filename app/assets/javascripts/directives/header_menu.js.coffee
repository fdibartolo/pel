angular.module("cems.directives", []).directive "headerMenu", ->
  restrict: "A"
  templateUrl: "/templates/header_menu.html"
  replace: true