angular.module('cems.services').factory 'RequestService', 
['$q', '$http', ($q, $http) ->

  all = ->
    deferred = $q.defer()
    $http.get('/api/requests/all').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get inbox requests"

    deferred.promise

  newRequest = ->
    deferred = $q.defer()
    $http.get('/api/requests/new').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get template Request"

    deferred.promise

  createOrUpdate = (request) ->
    deferred = $q.defer()

    if request.id == undefined
      method = 'POST'
      url = '/api/requests'
    else
      method = 'PUT'
      url = '/api/requests/' + request.id

    $http({method: method, url: url, data: request}).success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to create/update Request"

    deferred.promise

  all: all,
  new: newRequest,
  create: createOrUpdate
]
