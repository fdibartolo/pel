angular.module('cems.controllers').controller 'DashboardController', ['$scope', '$location', 'PersonalEngagementListService', ($scope, $location, PersonalEngagementListService) ->
  $scope.init = ->
    PersonalEngagementListService.all().then (pels) ->
      $scope.pels = pels

  $scope.new = ->
    $location.path("/new")
]
