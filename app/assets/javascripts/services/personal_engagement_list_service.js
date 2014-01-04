angular.module('cems.services', [])
  .factory('PersonalEngagementListService', [
    '$q', '$http', function ($q, $http) {

      var all = function () {
        return [
          {Id:1, Name : "Pel 1"},
          {Id:2, Name:"Pel 2"},
          {Id:3, Name:"Pel 3"}
        ];
      };

      return {
        all: all
      };
    } 
  ]);
