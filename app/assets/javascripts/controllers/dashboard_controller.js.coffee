angular.module('cems.controllers', []).controller 'DashboardController', ['$scope', 'PersonalEngagementListService', ($scope, PersonalEngagementListService) ->
  $scope.init = ->
    # $scope.pels = PersonalEngagementListService.all()
    PersonalEngagementListService.all().then (pels) ->
      $scope.pels = pels
]
