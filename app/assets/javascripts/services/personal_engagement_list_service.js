angular.module('cems.services', [])
  .factory('PersonalEngagementListService', [
    '$q', '$http', function ($q, $http) {

      var all = function () {
        return [];
        // var deferred = $q.defer();
        // var auth = "Basic " + btoa(credentials.username + ":" + credentials.password);
        // var custom_headers = { headers: { 'Authorization': auth} };

        // $loadDialog.showModal('Loading, please wait...');

        // $http.get(projectsUrl, custom_headers).
        //   success(function (data, status) {
        //     SessionService.setAuthToken(auth);
        //     SessionService.setUserProjects(data);
        //     deferred.resolve();
        //     $loadDialog.hide();
        //   }).
        //   error(function (data, status) {
        //     deferred.reject();
        //     $loadDialog.hide();
        //     alert("Unable to login, please make sure your credentials are valid");
        //   });

        // return deferred.promise;
      };

      return {
        all: all
      };
    } 
  ]);
