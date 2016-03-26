angular.module('busApp', ['ui.bootstrap', 'restangular', 'ngGrid'])
.controller('newBusStop',
[
  '$scope',
  '$http',
  '$modal',
  'Restangular',
  function($scope, $http, $modal, $rest) {
    $scope.getStateDistrictData = function() {
      $rest.all('bus_stops/state_district_data.json').get('')
      .then(function(data) {
        $scope.stateDistrictdata = data;
      }, function() {
        alert('Error fetching state-district data');
      });
    };

    $scope.getStateDistrictData();
  }
]); 
