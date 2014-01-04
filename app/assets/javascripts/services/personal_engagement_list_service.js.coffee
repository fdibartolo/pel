angular.module('cems.services', []).factory 'PersonalEngagementListService', ['$q', '$http', ($q, $http) ->
  all = ->
    [
      Id: 1
      Name: 'Pel 1'
    ,
      Id: 2
      Name: 'Pel 2'
    ,
      Id: 3
      Name: 'Pel 3'
    ]

  all: all
]