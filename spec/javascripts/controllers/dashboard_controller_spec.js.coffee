describe "DashboardController", ->
  ctrl = undefined
  scope = undefined

  beforeEach module("cems.controllers")
  beforeEach module("cems.services")

  beforeEach inject(($rootScope, $controller) ->
    scope = $rootScope.$new()
    ctrl = $controller("DashboardController",
      $scope: scope
    )
    return
  )

  describe "personal engagement list isNew", ->
    it "should be true if it was created on a differet day", ->
      pel = {"created_at":"2014-01-20T21:13:08.000Z"}
      expect(scope.isNew(pel)).toBeFalsy()
      return

    it "should be false if it was created on the given day", ->
      pel = {"created_at":"2014-01-20T21:13:08.000Z"}
      today = new Date(Date.parse(pel.created_at))
      expect(scope.isNew(pel, today)).toBeTruthy()
      return

  return
