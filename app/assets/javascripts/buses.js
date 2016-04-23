angular.module('busApp')
.controller('newBus', 
[   
  '$scope',
  '$http',
  '$uibModal',
  '$window',
  'Restangular',
  function($scope, $http, $modal, $window, $rest) {
    $scope.bus = {};
    $scope.busStops = [];
    $scope.conductors = [];
    handler = Gmaps.build('Google');
    markers = null;

    //Default initializations
    $scope.bus.status = "off";
    $scope.bus.latitude = 23.384096;
    $scope.bus.longitude = 77.497747;
    $scope.bus.seat_avail = 0
    
    $scope.initMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        centerPoint = new google.maps.LatLng(23.384096, 77.497747);
        handler.fitMapToBounds();
        handler.getMap().setCenter(centerPoint);
        handler.getMap().setZoom(4);
      });
    };
    

    $scope.getBusStops = function() {
      $rest.all("bus_stops.json").get("")
      .then(function(data) {
        $scope.busStops = data["bus_stops"];
      }, function() {
        alert("Error in fetching bus stops");
      });
    };

    $scope.getConductors = function() {
      $rest.setRequestSuffix('.json');
      $rest.all("users/conductors").get("")
      .then(function(data) {
        $scope.conductors = data["conductors"];
      }, function() {
        alert("Error in fetching conductors");
      });
    };

    $scope.validateForm = function() {
      formAngularElem = angular.element(".new_bus")[0];
      submitAngularElem = angular.element(".submit")[0];
      valid = formAngularElem.checkValidity();
      if(!valid)
        submitAngularElem.click();
      return valid;
    };

    $scope.enumerateStops = function() {
      for(i = 0; i < $scope.bus.route.length; i++) {
        $scope.bus.route[i].stop_num = i;
      }
    };

    $scope.submit = function() {
      if(!$scope.validateForm())
        return;
      $scope.enumerateStops();
      params = {'bus': $scope.bus};
      $rest.setRequestSuffix('.json');
      $rest.one('buses').post('', params)
      .then(function(data) {
        $window.location.href = "/buses/" + data["bus"]["id"];
      }, function() {
        alert('Error in creating new bus');
      }
      );
    };

    $scope.buildMarkers = function() {
      markerArray = [];
      for(i = 0; i < $scope.bus.route.length; i++) {
        lat = $scope.bus.route[i].latitude;
        lng = $scope.bus.route[i].longitude;
        stop_name = $scope.bus.route[i].name;
        markerArray.push({"lat": lat, "lng": lng, "infowindow": stop_name});
      }
      return markerArray;
    };

    $scope.showBusStopsOnMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers($scope.buildMarkers());
        handler.bounds.extendWith(markers);
        handler.getMap().setZoom(16);
        handler.fitMapToBounds();
      });
    };

    $scope.initMap();
    $scope.getBusStops();
    $scope.getConductors();

    $scope.$watch("bus.route", function() {
      $scope.showBusStopsOnMap();
    });

  }
]);

angular.module('busApp')
.controller('editBus',
[
  '$scope',
  '$http',
  '$uibModal',
  '$location',
  '$filter',
  '$window',
  'Restangular',
  function($scope, $http, $modal, $location, $filter, $window, $rest) {
    //Parse URL http://host:port/buses/:id/edit
    urlFrags = $location.absUrl().match(/(.*)\/\/(.*)\/(.*)\/(.*)\/(.*)/);
    busId = parseInt(urlFrags[4]);

    $scope.bus = {};
    $scope.busStops = []
    handler = Gmaps.build('Google');
    markers = null;

    
    $scope.initMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        centerPoint = new google.maps.LatLng(23.384096, 77.497747);
        handler.fitMapToBounds();
        handler.getMap().setCenter(centerPoint);
        handler.getMap().setZoom(4);
      });
    };
    

    $scope.getBus = function() {
      $rest.setRequestSuffix('.json');
      $rest.one('buses', busId).get()
      .then(function(data) {
        $scope.$watch("bus.route", function() {
          $scope.showBusStopsOnMap();
        });
        $scope.bus = data['bus'];
        $scope.bus.route = $filter('orderBy')($scope.bus.route, "stop_num", false);
      }, function() {
        alert('Error fetching bus');
      });
    };

    $scope.getBusStops = function() {
      $rest.all("bus_stops.json").get("")
      .then(function(data) {
        $scope.busStops = data["bus_stops"];
      }, function() {
        alert("Error in fetching bus stops");
      });
    };

    $scope.getConductors = function() {
      $rest.setRequestSuffix('.json');
      $rest.all("users/conductors").get("")
      .then(function(data) {
        $scope.conductors = data["conductors"];
      }, function() {
        alert("Error in fetching conductors");
      });
    };

    $scope.validateForm = function() {
      formAngularElem = angular.element(".edit_bus")[0];
      submitAngularElem = angular.element(".submit")[0];
      valid = formAngularElem.checkValidity();
      if(!valid)
        submitAngularElem.click();
      return valid;
    };

    $scope.enumerateStops = function() {
      for(i = 0; i < $scope.bus.route.length; i++) {
        $scope.bus.route[i].stop_num = i;
      }   
    };

    $scope.submit = function() {
      if(!$scope.validateForm())
        return;
      $scope.enumerateStops();
      params = {'bus': $scope.bus};
      $rest.setRequestSuffix('.json');
      $rest.one('buses', busId).customPUT(params)
      .then(function(data) {
        $window.location.href = "/buses/" + busId;
      }, function() {
        alert('Error in creating new bus');
      }
      );
    };

    $scope.buildMarkers = function() {
      markerArray = [];
      for(i = 0; i < $scope.bus.route.length; i++) {
        lat = $scope.bus.route[i].latitude;
        lng = $scope.bus.route[i].longitude;
        stop_name = $scope.bus.route[i].name;
        markerArray.push({"lat": lat, "lng": lng, "infowindow": stop_name});
      }
      return markerArray;
    };

    $scope.showBusStopsOnMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers($scope.buildMarkers());
        handler.bounds.extendWith(markers);
        handler.getMap().setZoom(16);
        handler.fitMapToBounds();
      });
    };

    $scope.initMap();
    $scope.getBus();
    $scope.getBusStops();
    $scope.getConductors();
  }
]);

