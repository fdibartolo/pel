angular.module('cems.controllers', []).controller 'DashboardController', ['$scope', 'PersonalEngagementListService', ($scope, PersonalEngagementListService) ->
  $scope.init = ->
    PersonalEngagementListService.all().then (pels) ->
      $scope.pels = pels
]
