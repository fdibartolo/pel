angular.module('cems.services', []).factory 'PersonalEngagementListService', ['$q', '$http', ($q, $http) ->
  all = ->
    deferred = $q.defer()
    $http.get('/lists').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get lists"

    deferred.promise

  all: all
]

