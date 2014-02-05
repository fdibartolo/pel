angular.module('cems.controllers').controller 'DashboardController', 
['$scope', '$location', 'PersonalEngagementListService', 'RequestService', ($scope, $location, PersonalEngagementListService, RequestService) ->

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
    RequestService.all().then (requests) ->
      $scope.requests = requests
]
