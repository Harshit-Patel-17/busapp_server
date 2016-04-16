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
    //handler = Gmaps.build('Google');
    markers = null;
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

    //$scope.initMap();
    $scope.getBusStops();
  }
]);
