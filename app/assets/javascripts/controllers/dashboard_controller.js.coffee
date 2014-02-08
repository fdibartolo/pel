angular.module('cems.controllers').controller 'DashboardController', 
['$scope', '$location', '$filter', 'PersonalEngagementListService', 'RequestService', ($scope, $location, $filter, PersonalEngagementListService, RequestService) ->

  $scope.init = ->
    PersonalEngagementListService.all().then (pels) ->
      $scope.pels = pels

  $scope.new = ->
    $location.path("/new")

  $scope.edit = (id) ->
    $location.path("/edit/" + id)

  $scope.isNew = (pel, today) ->
    if (typeof(today) == "undefined")
      today = new Date()

    createdAt = new Date(Date.parse(pel.created_at))
    today.toDateString() == createdAt.toDateString()

  $scope.inbox = ->
    PersonalEngagementListService.all().then (pels) ->
      $scope.pels = pels
      RequestService.all().then (requests) ->
        $scope.requests = requests

  $scope.selectPelForRequisition = (request, pelId, text) ->
    request.pelId = pelId
    request.submitButtonText = $filter('date')(text,'mediumDate')
  
  $scope.cannotSubmitRequisitionFor = (request) ->
    typeof(request.pelId) == "undefined"

  $scope.submitRequisitionFor = (request) ->
    RequestService.submitRequisition(request).then (result) ->
      if result.errors != undefined
        alert($scope.errors)

]
