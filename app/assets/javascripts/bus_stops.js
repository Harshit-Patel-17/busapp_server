angular.module('busApp', ['ui.bootstrap', 'restangular', 'ngGrid'])
.controller('newBusStop',
[
  '$scope',
  '$http',
  '$uibModal',
  'Restangular',
  function($scope, $http, $modal, $rest) {
    $scope.stateDistrictData = {};
    $scope.states = [];

    $scope.getStateDistrictData = function() {
      $rest.all('bus_stops/state_district_data.json').get('')
      .then(function(data) {
        $scope.stateDistrictData = data['data'];
        $scope.extractStates();
      }, function() {
        alert('Error fetching state-district data');
      });
    };

    $scope.extractStates = function() {
      angular.forEach($scope.stateDistrictData, function(districts, state) {
        $scope.states.push(state);
      });
    };

    $scope.getStateDistrictData();
  }
]); 

angular.module('busApp')
.controller('editBusStop',
[
  '$scope',
  '$http',
  '$uibModal',
  '$location',
  'Restangular',
  function($scope, $http, $modal, $location, $rest) {
    //Parse URL http://host:port/bus_stops/:id/edit
    urlFrags = $location.absUrl().match(/(.*)\/\/(.*)\/(.*)\/(.*)\/(.*)/);
    busStopId = parseInt(urlFrags[4]);
    $scope.busStop = {};    

    $scope.getBusStop = function() {
      $rest.setRequestSuffix('.json');
      $rest.one('bus_stops', busStopId).get()
      .then(function(data) {
        $scope.busStop = data['bus_stop'];
      }, function() {
        alert('Error fetching bus stop');
      });
    }

    $scope.stateDistrictData = {};
    $scope.states = [];
      
    $scope.getStateDistrictData = function() {
      $rest.all('bus_stops/state_district_data.json').get('')
      .then(function(data) {
        $scope.stateDistrictData = data['data'];
        $scope.extractStates();
      }, function() {
        alert('Error fetching state-district data');
      });
    };

    $scope.extractStates = function() {
      angular.forEach($scope.stateDistrictData, function(districts, state) {
        $scope.states.push(state);
      });
    };

    $scope.getStateDistrictData();
    $scope.getBusStop();
  }
]); 

angular.module('busApp')
.directive('stringToNumber', function() {
  return {
    require: 'ngModel',
    link: function(scope, element, attrs, ngModel) {
      ngModel.$parsers.push(function(value) {
        return '' + value;
      });
      ngModel.$formatters.push(function(value) {
        return parseFloat(value, 10);
      });
    }
  };
});
