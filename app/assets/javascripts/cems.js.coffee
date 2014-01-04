app = angular.module('cems', ['ngRoute', 'cems.services', 'cems.controllers'])

app.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/dashboard',
    templateUrl: '/templates/dashboard.html'
    controller: 'DashboardController'

  $routeProvider.otherwise redirectTo: '/dashboard'
]