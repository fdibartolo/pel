angular.module('cems.services', []).factory 'PersonalEngagementListService', ['$q', '$http', ($q, $http) ->
  all = ->
    deferred = $q.defer()
    $http.get('/lists').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get lists"

    deferred.promise

  new_pel = ->
    deferred = $q.defer()
    $http.get('/new').success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to get template PEL"

    deferred.promise

  submit = (pel) ->
    deferred = $q.defer()
    $http.post('/create', pel).success((data, status) ->
      deferred.resolve(data)
    ).error (data, status) ->
      deferred.reject()
      alert "Unable to submit PEL"

    deferred.promise

  all: all,
  new: new_pel,
  submit: submit
]
