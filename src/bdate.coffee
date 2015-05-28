angular.module 'bdate.datepicker', ['bdate.popup', 'bdate.data', 'bdate.templates']

.directive 'bdatepicker', ($filter, bDataFactory) ->
  restrict: 'E'
  replace: true
  templateUrl: 'bdate.html'
  scope:
    source: '='
    bRootId: '@?'
    bInputId: '@?'
    bPopupId: '@?'
  controller: ->
#TODO we should disable datepicker somehow until data received from server
    bDataFactory.makeDataQuery()
  link: (scope) ->
    scope.date =
      viewed: ''
      model: {}

    scope.$watch 'date.model', ->
      return if angular.equals {}, scope.date.model
      dateTime = new Date(scope.date.model.year, scope.date.model.month - 1, scope.date.model.day).getTime()
      formattedDate = $filter('date')(dateTime, bDataFactory.data.format) 
      scope.date.viewed = formattedDate

    scope.popup =
      state:
        isOpen: false

    scope.togglePopup = () ->
      scope.popup.state.isOpen = not scope.popup.state.isOpen