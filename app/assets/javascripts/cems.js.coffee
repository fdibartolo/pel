app = angular.module('cems', ['ngRoute', 'cems.services', 'cems.controllers'])

# Created here so controllers on separate files can be built on top of this one
controllers = angular.module('cems.controllers', [])

app.config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/dashboard',
    templateUrl: '/templates/dashboard.html'
    controller: 'DashboardController'

  $routeProvider.when '/new',
    templateUrl: '/templates/new.html'
    controller: 'PersonalEngagementListController'

  $routeProvider.otherwise redirectTo: '/dashboard'
]