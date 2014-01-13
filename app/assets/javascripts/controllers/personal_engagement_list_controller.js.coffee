angular.module('cems.controllers').controller 'PersonalEngagementListController', ['$scope', '$location', 'PersonalEngagementListService', ($scope, $location, PersonalEngagementListService) ->
  $scope.init = ->
    PersonalEngagementListService.new().then (pel) ->
      $scope.pel = pel

  $scope.submit = ->
    alert "Boom!"
    console.log $scope.pel

  $scope.cancel = ->
    $location.path("/dashboard")
]