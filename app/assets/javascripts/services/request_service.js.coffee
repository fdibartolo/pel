angular.module('cems.services').factory 'RequestService', 
['$q', '$http', ($q, $http) ->

  newRequest = ->
    deferred = $q.defer()
    $http.get('/api/requests/new').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get template Request"

    deferred.promise

  create = (request) ->
    deferred = $q.defer()
    $http.post('/api/requests', request).success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to create Request"

    deferred.promise

  new: newRequest,
  create: create
]
