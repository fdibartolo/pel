app = angular.module('cems', ['ngRoute', 'ui.sortable', 'cems.services', 'cems.controllers'])

# Created here so controllers on separate files can be built on top of this one
controllers = angular.module('cems.controllers', [])

app.config ['$httpProvider', '$routeProvider', ($httpProvider, $routeProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken  
  
  $routeProvider.when '/dashboard',
    templateUrl: '/templates/dashboard.html'
    controller: 'DashboardController'

  $routeProvider.when '/new',
    templateUrl: '/templates/new.html'
    controller: 'PersonalEngagementListController'

  $routeProvider.when '/edit/:id',
    templateUrl: '/templates/new.html'
    controller: 'PersonalEngagementListController'

  $routeProvider.otherwise redirectTo: '/dashboard'
]
