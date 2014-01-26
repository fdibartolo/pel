angular.module('cems.services', []).factory 'PersonalEngagementListService', ['$q', '$http', ($q, $http) ->
  all = ->
    deferred = $q.defer()
    $http.get('/api/personal_engagement_lists/lists').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get lists"

    deferred.promise

  newPel = ->
    deferred = $q.defer()
    $http.get('/api/personal_engagement_lists/new').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get template PEL"

    deferred.promise

  getById = (id) ->
    deferred = $q.defer()
    $http.get('/api/personal_engagement_lists/' + id + '/edit').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get PEL"

    deferred.promise

  submit = (pel) ->
    deferred = $q.defer()

    if pel.id == undefined
      method = 'POST'
      url = '/api/personal_engagement_lists'
    else
      method = 'PUT'
      url = '/api/personal_engagement_lists/' + pel.id

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
