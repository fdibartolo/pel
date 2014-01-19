angular.module('cems.services', []).factory 'PersonalEngagementListService', ['$q', '$http', ($q, $http) ->
  all = ->
    deferred = $q.defer()
    $http.get('/lists').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get lists"

    deferred.promise

  newPel = ->
    deferred = $q.defer()
    $http.get('/new').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get template PEL"

    deferred.promise

  getById = (id) ->
    deferred = $q.defer()
    $http.get('/edit/' + id).success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get PEL"

    deferred.promise

  submit = (pel) ->
    deferred = $q.defer()

    if pel.id == undefined
      method = 'POST'
      url = '/create'
    else
      method = 'PUT'
      url = '/lists/' + pel.id

    $http({method: method, url: url, data: pel}).success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to submit PEL"

    deferred.promise

  all: all,
  new: newPel,
  getById: getById,
  submit: submit
]
