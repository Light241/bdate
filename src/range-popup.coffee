angular.module 'bdate.popup.ranged', [
  'bdate.templates'
]

.directive 'bdateRangePopup', () ->
  restrict: 'E'
  replace: true
  templateUrl: 'range-popup.html'
  scope:
    popupState: '='
    popupSettings: '='
    popupStartSource: '='
    popupEndSource: '='
    popupResult: '='
    popupStartRefresh: "&?"
    popupEndRefresh: "&?"
  link: (scope) ->
    scope.data =
      startDate: ''
      endDate: ''

    getSource = (isStartPopup) ->
      if isStartPopup
        return scope.popupStartSource
      else
        return scope.popupEndSource

    scope.popup =
      hidePopup: () ->
        scope.popupState.isOpen = false
      selectDate: (isStartPopup, date) ->
        scope.popupResult = date
        scope.popup.hidePopup()
        if not scope.popup.isDayInSelectedMonth date
          scope.popup.refreshSelectedData date.month, date.year
      goPrevYear: (isStartPopup) ->
        popupSource = getSource isStartPopup

        return if not popupSource or not popupSource.year
        if popupSource.year.isStart
          console.error 'error'
          return false
        year = popupSource.year.num - 1
        month = popupSource.month.num
        scope.popup.refreshSelectedData month, year
      isFirstYear: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource
        return popupSource.year.isStart
      goPrevMonth: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource.year
        if popupSource.month.isStart and popupSource.year.isStart
          console.error 'error'
          return false

        december = 12
        month = popupSource.month.num

        if popupSource.month.isStart
          year = popupSource.year.num - 1
          month = december
        else if popupSource.month.isStart and popupSource.year.isStart
          console.error 'error'
          return false
        else
          year = popupSource.year.num
          month = popupSource.month.num - 1

        scope.popup.refreshSelectedData month, year
      isFirstMonth: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource
        return popupSource.month.isStart
      goNextMonth: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource.year
        if popupSource.month.isEnd and popupSource.year.isEnd
          console.error 'error'
          return false

        january = 1
        month = popupSource.month.num

        if popupSource.month.isEnd
          year = popupSource.year.num + 1
          month = january
        else if popupSource.month.isEnd and popupSource.year.isEnd
          console.error 'error'
          return false
        else
          year = popupSource.year.num
          month = popupSource.month.num + 1

        scope.popup.refreshSelectedData month, year
      isLastMonth: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource
        return popupSource.month.isEnd
      goNextYear: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource.year
        if popupSource.year.isEnd
          console.error 'error'
          return false
        year = popupSource.year.num + 1
        month = popupSource.month.num
        scope.popup.refreshSelectedData month, year
      isLastYear: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource
        return popupSource.year.isEnd
      isSelectedDay: (date) ->
        return if not scope.popupResult or not scope.popupResult.day
        return ((date.day is scope.popupResult.day) and (date.month is scope.popupResult.month) and (date.year is scope.popupResult.year))
      getTodayDateTime: (isStartPopup) ->
        popupSource = getSource isStartPopup
        return if not popupSource or not popupSource.today
        today = popupSource.today
        return new Date(today.year, today.month - 1, today.day).getTime()
      isDayInSelectedMonth: (isStartPopup, date) ->
        popupSource = getSource isStartPopup
        return ((date.month is popupSource.month.num) and (date.year is popupSource.year.num))
      goToYear: (isStartPopup) ->
        popupSource = getSource isStartPopup
        year = popupSource.year.num
        month = popupSource.month.num
        scope.popup.refreshSelectedData month, year
      refreshSelectedData: (month, year) ->
        scope.popupRefresh
          m: month
          y: year

    scope.$watch 'popupSource', ->
      scope.isDataReady = true
    , true
