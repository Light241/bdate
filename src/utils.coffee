angular.module 'bdate.utils', ['bdate.data']

.factory 'bDateUtils', (MESSAGES, bDataFactory) ->
  daysOfWeek = [
    {name: 'Понедельник', short: 'Пн'}
    {name: 'Вторник', short: 'Вт'}
    {name: 'Среда', short: 'Ср'}
    {name: 'Четверг', short: 'Чт'}
    {name: 'Пятница', short: 'Пт'}
    {name: 'Суббота', short: 'Сб'}
    {name: 'Воскресенье', short: 'Вс'}
  ]

  month = [
    {name: 'Январь', short: 'Янв'}
    {name: 'Февраль', short: 'Фев'}
    {name: 'Март', short: 'Март'}
    {name: 'Апрель', short: 'Май'}
    {name: 'Май', short: 'Май'}
    {name: 'Июнь', short: 'Июнь'}
    {name: 'Июль', short: 'Июль'}
    {name: 'Август', short: 'Авг'}
    {name: 'Сентябрь', short: 'Сент'}
    {name: 'Октябрь', short: 'Окт'}
    {name: 'Ноябрь', short: 'Ноя'}
    {name: 'Декабрь', short: 'Дек'}
  ]

  return exports =
    daysOfWeek: daysOfWeek
    month: month
    getDaysOfWeekShorts: ->
      i = 0
      result = []
      while i < daysOfWeek.length
        result.push daysOfWeek[i].short
        i++
      return result
    getMonthName: (number)->
      return month[number].name
    sourceCheckers:
      month:
        isMonthExist: (yearNum, monthNum)->
          return console.error MESSAGES.invalidParams if not yearNum or not monthNum
          yearNum = +yearNum
          monthNum = +monthNum
          return false if not bDataFactory.data.years[yearNum]
          !!bDataFactory.data.years[yearNum][monthNum]
        isFirstMonth: (yearNum, monthNum) ->
          yearNum = +yearNum
          monthNum = +monthNum
          monthNum is +Object.keys(bDataFactory.data.years[yearNum])[0]
        getFirstMonth: (yearNum) ->
          yearNum = +yearNum
          +Object.keys(bDataFactory.data.years[yearNum])[0]
        isLastMonth: (yearNum, monthNum) ->
          yearNum = +yearNum
          monthNum = +monthNum
          monthNum is +Object.keys(bDataFactory.data.years[yearNum])[Object.keys(bDataFactory.data.years[yearNum]).length - 1]
        getLastMonth: (yearNum) ->
          yearNum = +yearNum
          +Object.keys(bDataFactory.data.years[yearNum])[Object.keys(bDataFactory.data.years[yearNum]).length - 1]
        getNextAvailableMonth: (isForward, yearNum, monthNum) ->
          yearNum = +yearNum
          monthNum = +monthNum
          isFirstMonth = exports.sourceCheckers.month.isFirstMonth yearNum, monthNum
          isLastMonth = exports.sourceCheckers.month.isLastMonth yearNum, monthNum
          isChangeYear = false
          nextYearNum = yearNum
          nextMonth = monthNum

          if isForward
            if not isLastMonth
              nextMonth = monthNum + 1
            else
              isChangeYear = true
              nextYearNum = yearNum + 1
              if scope.data.isYearExist nextYearNum
                nextMonth = exports.sourceCheckers.month.getFirstMonth nextYearNum
              else
                console.error MESSAGES.errorOnChangeMonthOrYear
                return false
          else if not isForward
            if not isFirstMonth
              nextMonth = monthNum - 1
            else
              isChangeYear = true
              nextYearNum = yearNum - 1
              if exports.sourceCheckers.year.isYearExist nextYearNum
                nextMonth = exports.sourceCheckers.month.getLastMonth nextYearNum
              else
                console.error MESSAGES.errorOnChangeMonthOrYear
                return false

          result =
            year: nextYearNum
            month: nextMonth
      year:
        isYearExist: (yearNum) ->
          return console.error MESSAGES.invalidParams if not yearNum
          yearNum = +yearNum
          !!bDataFactory.data.years[yearNum]
        isFirstYear: (yearNum) ->
          yearNum = +yearNum
          yearNum is +Object.keys(bDataFactory.data.years)[0]
        getFirstYear: ->
          +Object.keys(bDataFactory.data.years)[0]
        isLastYear: (yearNum) ->
          yearNum = +yearNum
          yearNum is +Object.keys(bDataFactory.data.years)[Object.keys(bDataFactory.data.years).length - 1]
        getLastYear: ->
          +Object.keys(bDataFactory.data.years)[Object.keys(bDataFactory.data.years).length - 1]
        getNextAvailableYear: (isForward, yearNum, monthNum) ->
          yearNum = +yearNum
          monthNum = +monthNum
          isFirstYear = exports.sourceCheckers.year.isFirstYear yearNum
          isLastYear = exports.sourceCheckers.year.isLastYear yearNum
          isMonthExistInYear = exports.sourceCheckers.month.isMonthExist yearNum monthNum
          nextYearNum = yearNum
          nextMonth = monthNum

          if isForward
            if not isLastYear
              nextMonth = monthNum + 1
            else
              nextYearNum = yearNum + 1
              if exports.sourceCheckers.year.isYearExist nextYearNum
                nextMonth = exports.sourceCheckers.month.getFirstMonth nextYearNum
              else
                console.error MESSAGES.errorOnChangeMonthOrYear
                return false
          else if not isForward
            if not isFirstYear
              nextMonth = monthNum - 1
            else
              nextYearNum = yearNum - 1
              if exports.sourceCheckers.year.isYearExist nextYearNum
                nextMonth = exports.sourceCheckers.month.getLastMonth nextYearNum
              else
                console.error MESSAGES.errorOnChangeMonthOrYear
                return false

          result =
            year: nextYearNum
            month: nextMonth