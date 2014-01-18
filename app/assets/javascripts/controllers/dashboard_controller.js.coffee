angular.module('cems.controllers').controller 'DashboardController', 
['$scope', '$location', 'PersonalEngagementListService', ($scope, $location, PersonalEngagementListService) ->

  $scope.init = ->
    PersonalEngagementListService.all().then (pels) ->
      $scope.pels = pels

  $scope.new = ->
    $location.path("/new")

  $scope.isNew = (pel) ->
    createdAt = new Date(Date.parse(pel.created_at))
    new Date().toDateString() == createdAt.toDateString()
]
