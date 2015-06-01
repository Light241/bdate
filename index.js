'use strict';

angular.module('app', [
    'bdate'
])

    .controller('IndexPageCtrl', function ($scope, $timeout) {

        $scope.demoData = {};

        $timeout(function(){
            $scope.demoData = {
                "format": "dd-MM-yyyy",
                "delimiter": "-",
                "today": {
                    "date": 1432537266825,
                    "year": 2015,
                    "month": 5,
                    "day": 25,
                    "day_of_week": 1
                },
                "years": {
                    "2013": {
                        "1": {
                            "days_total": 31,
                            "start_day": 2
                        }
                    },
                    "2014": {
                        "5": {
                            "days_total": 31,
                            "start_day": 4
                        },
                        "6": {
                            "days_total": 30,
                            "start_day": 7
                        },
                        "7": {
                            "days_total": 31,
                            "start_day": 2
                        },
                        "8": {
                            "days_total": 31,
                            "start_day": 5
                        },
                        "9": {
                            "days_total": 30,
                            "start_day": 1
                        },
                        "10": {
                            "days_total": 31,
                            "start_day": 3
                        }
                    },
                    "2015": {
                        "2": {
                            "days_total": 28,
                            "start_day": 7
                        },
                        "3": {
                            "days_total": 31,
                            "start_day": 5
                        },
                        "4": {
                            "days_total": 30,
                            "start_day": 3
                        },
                        "5": {
                            "days_total": 31,
                            "start_day": 5
                        }
                    },
                    "2016": {
                        "1": {
                            "days_total": 31,
                            "start_day": 5
                        }
                    },
                    "2017": {
                        "1": {
                            "days_total": 31,
                            "start_day": 7
                        },
                        "2": {
                            "days_total": 28,
                            "start_day": 3
                        }
                    }
                }
            };
        }, 2000);


        $scope.resultModel = '';
    })
;
