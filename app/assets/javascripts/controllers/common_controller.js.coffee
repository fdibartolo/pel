angular.module('cems.controllers').controller 'CommonController', 
['$rootScope', ($rootScope) ->

  $rootScope.showSpinner = false

  $rootScope.$on 'showLoadingSpinner', () ->
    $rootScope.showSpinner = true

  $rootScope.$on 'hideLoadingSpinner', () ->
    $rootScope.showSpinner = false
]