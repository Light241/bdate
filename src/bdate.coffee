angular.module 'bdate', [
  'bdate.popup'
  'bdate.templates'
]

.directive 'bdatepicker', ($document, $filter) ->
  restrict: 'E'
#replace: true
  templateUrl: 'bdate.html'
  scope:
    bModel: '='
    bSource: '=?'
    bStartSource: '=?'
    bEndSource: '=?'
    bRange: '=?'
    bRootClasses: '@?'
    bInputClasses: '@?'
    bButtonClasses: '@?'
    bPopupClasses: '@?'
    bMonthNames: '=?'
    bDaysNames: '=?'
    placeholder: '@?'
    bRefresh: "&?"
    bStartRefresh: "&?"
    bEndRefresh: "&?"
  controller: ($scope) ->
    $scope.state =
      isDataReady: false

    $scope.data =
      date: null

    $scope.$watch 'bSource', ->
      $scope.isDataReady = true
    , true

    getFormattedDate = (dmy) ->
      datetime = new Date(dmy.year, dmy.month - 1, dmy.day).getTime()
      return $filter('date') datetime, $scope.bSource.format

    $scope.$watch 'popupResult', (newVal, oldVal) ->
      return if newVal is oldVal
      return if not newVal
      return if angular.equals {}, newVal
      $scope.bModel = getFormattedDate($scope.popupResult)
    , true

  link: (scope, elem) ->
    scope.date =
      viewed: ''
      model: {}

    processClick = (event) ->
      isOpen = scope.popup.state.isOpen
      clickedElem = event.target
      popupElem = elem
      isOutsideClick = (popupElem isnt clickedElem) and not (popupElem[0].contains clickedElem)
      if isOpen and isOutsideClick
        scope.$apply ->
          scope.popup.hidePopup()

    scope.clear = () ->
      scope.bModel = null;
      scope.popupResult = null;

    scope.popup =
      state:
        isOpen: false
      togglePopup: () ->
        return if not scope.isDataReady
        scope.popup.state.isOpen = not scope.popup.state.isOpen
      hidePopup: () ->
        scope.popup.state.isOpen = false

    do () ->
      scope.bRefresh()

    scope.bRefreshTest = (m, y) ->
      scope.bRefresh
        m: m
        y: y


    $document.on 'click', processClick