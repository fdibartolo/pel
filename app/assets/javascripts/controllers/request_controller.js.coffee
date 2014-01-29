angular.module('cems.controllers').controller 'RequestController', 
['$scope', '$location', 'RequestService', ($scope, $location, RequestService) ->

  $scope.init = ->
    $scope.errors = null
    RequestService.new().then (request) ->
      $scope.request = request

  $scope.create = ->
    sanitizeRecipients()
    RequestService.create($scope.request).then (result) ->
      $scope.request.recipients = result.valid_recipients.join(', ')
      $scope.invalid_recipients = result.invalid_recipients
      if result.errors != undefined
        $scope.errors = result.errors

  sanitizeRecipients = ->
    console.log $scope.request
    $scope.request.recipients = $scope.request.recipients.trim()
    $scope.request.recipients = $scope.request.recipients.split(",")
    # angular.forEach $scope.request.recipients, (recipient) ->
    #   recipient = recipient.trim()

    console.log $scope.request

  $scope.cancel = ->
    $location.path("/dashboard")
]