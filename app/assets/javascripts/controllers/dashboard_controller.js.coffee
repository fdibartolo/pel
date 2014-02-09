angular.module('cems.controllers').controller 'DashboardController', 
['$scope', '$location', '$filter', 'PersonalEngagementListService', 'RequestService', 'SessionService', 
($scope, $location, $filter, PersonalEngagementListService, RequestService, SessionService) ->

  $scope.init = ->
    PersonalEngagementListService.all().then (pels) ->
      SessionService.set 'pels', pels
      $scope.pels = pels

  $scope.new = ->
    $location.path("/new")

  $scope.edit = (id) ->
    $location.path("/edit/" + id)

  $scope.isNew = (pel, today) ->
    if typeof today is "undefined"
      today = new Date()

    createdAt = new Date(Date.parse(pel.created_at))
    today.toDateString() == createdAt.toDateString()

  $scope.inbox = ->
    $scope.pels = SessionService.get('pels')
    RequestService.all().then (requests) ->
      SessionService.set 'requests', requests
      $scope.requests = requests

  $scope.selectPelForRequisition = (request, pelId, text) ->
    request.selectedPelId = pelId
    request.submitButtonText = $filter('date')(text,'mediumDate')
  
  $scope.cannotSubmitRequisitionFor = (request) ->
    typeof request.selectedPelId is "undefined"

  $scope.submitRequisitionFor = (request) ->
    RequestService.submitRequisition(request).then (result) ->
      if typeof result.errors is "undefined"
        SessionService.broadcast('requestsUpdated')
        request.requisition_pel_id = request.selectedPelId
      else
        $scope.errors = result.errors
]
