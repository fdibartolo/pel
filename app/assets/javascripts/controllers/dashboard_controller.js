angular.module('cems.controllers', [])
  .controller('DashboardController', [
    '$scope', 'PersonalEngagementListService',
    function ($scope, PersonalEngagementListService) {

      $scope.init = function () {
        $scope.pels = PersonalEngagementListService.all();
        // $location.path('/lala');
      }
    }
  ]);
