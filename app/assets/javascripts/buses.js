angular.module('busApp')
.controller('newBus', 
[   
  '$scope',
  '$http',
  '$uibModal',
  'Restangular',
  function($scope, $http, $modal, $rest) {
    $scope.bus = {};
    $scope.busStops = []
    handler = Gmaps.build('Google');
    markers = null;

    //Default initializations
    $scope.bus.status = "off";
    $scope.bus.latitude = 23.384096;
    $scope.bus.longitude = 77.497747;
    $scope.bus.seat_avail = 0
    /*
    $scope.initMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        centerPoint = new google.maps.LatLng(23.384096, 77.497747);
        handler.fitMapToBounds();
        handler.getMap().setCenter(centerPoint);
        handler.getMap().setZoom(4);
      });
    };
    */

    $scope.getBusStops = function() {
      $rest.all("bus_stops.json").get("")
      .then(function(data) {
        $scope.busStops = data["bus_stops"];
      }, function() {
        alert("Error in fetching bus stops");
      });
    };

    $scope.submit = function() {
      params = {'bus': $scope.bus};
      $rest.setRequestSuffix('.json');
      $rest.one('buses').post('', params)
      .then(function(data) {
        alert(JSON.stringify(data));
      }, function() {
        alert('Error in creating new bus');
      }
      );
    };

    //$scope.initMap();
    $scope.getBusStops();
  }
]);
