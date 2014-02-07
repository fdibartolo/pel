angular.module('cems.controllers').controller 'RequestController', 
['$scope', '$location', 'RequestService', ($scope, $location, RequestService) ->

  $scope.init = ->
    $scope.errors = null
    RequestService.new().then (request) ->
      $scope.request = request

  $scope.create = ->
    buildSanitizedRecipientsList()
    RequestService.create($scope.request).then (result) ->
      $scope.request.id = result.id
      $scope.request.recipients = result.valid_recipients.join(', ')
      $scope.invalid_recipients = result.invalid_recipients
      if result.errors != undefined
        $scope.errors = result.errors

  buildSanitizedRecipientsList = ->
    $scope.request.recipients = removeWhitespacesFrom($scope.request.recipients)
    $scope.request.recipients = $scope.request.recipients.split(",")

  removeWhitespacesFrom = (string) ->
    string.replace RegExp(" ", "g"), ""

  $scope.cancel = ->
    $location.path("/dashboard")
]