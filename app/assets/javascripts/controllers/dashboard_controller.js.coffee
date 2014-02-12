angular.module('cems.controllers').controller 'DashboardController', 
['$scope', '$location', '$filter', 'PersonalEngagementListService', 'RequestService', 'SessionService', 
($scope, $location, $filter, PersonalEngagementListService, RequestService, SessionService) ->

  $scope.init = ->
    $scope.$emit 'showLoadingSpinner'
    PersonalEngagementListService.all().then (pels) ->
      SessionService.set 'pels', pels
      $scope.pels = pels
      $scope.$emit 'hideLoadingSpinner'

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
    $scope.$emit 'showLoadingSpinner'
    $scope.pels = SessionService.get('pels')
    RequestService.all().then (requests) ->
      SessionService.set 'requests', requests
      $scope.requests = requests
      $scope.$emit 'hideLoadingSpinner'

  $scope.selectPelForRequisition = (request, pelId, text) ->
    request.selectedPelId = pelId
    request.submitButtonText = $filter('date')(text,'mediumDate')
  
  $scope.cannotSubmitRequisitionFor = (request) ->
    typeof request.selectedPelId is "undefined"

  $scope.submitRequisitionFor = (request) ->
    $scope.$emit 'showLoadingSpinner'
    RequestService.submitRequisition(request).then (result) ->
      $scope.$emit 'hideLoadingSpinner'
      if typeof result.errors is "undefined"
        SessionService.broadcast('requestsUpdated')
        request.requisition_pel_id = request.selectedPelId
      else
        $scope.errors = result.errors
]
