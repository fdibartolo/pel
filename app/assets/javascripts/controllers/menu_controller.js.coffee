angular.module('cems.controllers').controller 'MenuController', 
['$scope', 'RequestService', ($scope, RequestService) ->

  RequestService.openRequestsCount().then (count) ->
    $scope.messageCount = count

  $scope.$on 'requestsUpdated', () ->
    RequestService.openRequestsCount().then (count) ->
      $scope.messageCount = count
]
