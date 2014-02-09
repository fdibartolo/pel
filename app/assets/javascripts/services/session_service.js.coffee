angular.module("cems.services").factory "SessionService",
["$rootScope", ($rootScope) ->

  return (
    set: (itemName, itemValue) ->
      return  if typeof itemName is "undefined"

      eval "$rootScope." + itemName + " =itemValue"
      return

    get: (itemName) ->
      return null  if typeof itemName is "undefined"
      v = eval("$rootScope." + itemName)
      return null  if typeof v is "undefined"
      v

    broadcast: (eventName) ->
      $rootScope.$broadcast eventName
  )
]
