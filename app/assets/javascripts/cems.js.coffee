app = angular.module('cems', ['ngRoute', 'ui.sortable', 'cems.services', 'cems.controllers', 'cems.directives'])

# Created here so modules on separate files can be built on top of this one
controllers = angular.module('cems.controllers', [])
services = angular.module('cems.services', [])
directives = angular.module('cems.directives', [])

app.config ['$httpProvider', '$routeProvider', ($httpProvider, $routeProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken  
  
  $routeProvider.when '/dashboard',
    templateUrl: '/templates/dashboard.html'
    controller: 'DashboardController'

  $routeProvider.when '/inbox',
    templateUrl: '/templates/inbox.html'
    controller: 'DashboardController'

  $routeProvider.when '/new',
    templateUrl: '/templates/new.html'
    controller: 'PersonalEngagementListController'

  $routeProvider.when '/edit/:id',
    templateUrl: '/templates/new.html'
    controller: 'PersonalEngagementListController'

  $routeProvider.when '/new_request',
    templateUrl: '/templates/new_request.html'
    controller: 'RequestController'

  $routeProvider.otherwise redirectTo: '/dashboard'
]
