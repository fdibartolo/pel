angular.module('cems.controllers').controller 'PersonalEngagementListController', ['$scope', '$location', 'PersonalEngagementListService', ($scope, $location, PersonalEngagementListService) ->
  $scope.init = ->
    PersonalEngagementListService.new().then (pel) ->
      $scope.pel = pel
      $scope.errors = null

  $scope.submit = ->
    updatePriorities()
    PersonalEngagementListService.submit($scope.pel).then (result) ->
      if result.errors == undefined
        $location.path("/dashboard")
      else
        $scope.errors = result.errors

  updatePriorities = ->
    angular.forEach $scope.pel.questions, (question, index) ->
      question.priority = index + 1
      
  $scope.cancel = ->
    $location.path("/dashboard")
]