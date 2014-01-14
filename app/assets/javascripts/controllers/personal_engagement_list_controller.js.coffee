angular.module('cems.controllers').controller 'PersonalEngagementListController', ['$scope', '$location', 'PersonalEngagementListService', ($scope, $location, PersonalEngagementListService) ->
  $scope.init = ->
    PersonalEngagementListService.new().then (pel) ->
      $scope.pel = pel

  $scope.submit = ->
    PersonalEngagementListService.submit($scope.pel).then (result) ->
      if result.errors == undefined
        $location.path("/dashboard")
      else
        alert result.errors

  $scope.cancel = ->
    $location.path("/dashboard")
]