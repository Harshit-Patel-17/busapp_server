angular.module('busApp')
.controller('newBusStop',
[
  '$scope',
  '$http',
  '$uibModal',
  'Restangular',
  function($scope, $http, $modal, $rest) {
    $scope.busStop = {};
    $scope.stateDistrictData = {};
    $scope.states = [];
    handler = Gmaps.build('Google');
    markers = null;
    address = "";

    $scope.initMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        centerPoint = new google.maps.LatLng(23.384096, 77.497747);
        handler.fitMapToBounds();
        handler.getMap().setCenter(centerPoint);
        handler.getMap().setZoom(4);
      });
    };

    $scope.showBusStopOnMap = function() {
      address = $scope.busStop['name'] + ',' + $scope.busStop['street'] + ',' + $scope.busStop['district']  + ',India';
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([
          {
            "lat": $scope.busStop['latitude'],
            "lng": $scope.busStop['longitude'],
            "infowindow": address
          }
        ]);
        centerPoint = new google.maps.LatLng($scope.busStop['latitude'], $scope.busStop['longitude']);
        handler.fitMapToBounds();
        handler.getMap().panTo(centerPoint);
        handler.getMap().setZoom(16);
      });
    };

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

    $scope.getLatLng = function() {
      address = $scope.busStop['name'] + ',' + $scope.busStop['street'] + ',' + $scope.busStop['district'] + ',India';
      params = {'address': address};
      $rest.setRequestSuffix('.json');
      $rest.one('bus_stops').one('lat_lng').post('', params)
      .then(function(data) {
        $scope.busStop['latitude'] = data['lat_lng']['lat'];
        $scope.busStop['longitude'] = data['lat_lng']['lng'];
        $scope.showBusStopOnMap();
      }, function() {
        alert('Error fetching lat-lng of the address');
      }
      ); 
    };

    $scope.initMap();
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
    handler = Gmaps.build('Google');
    markers = null;
    address = "";

    $scope.initMap = function() {
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        centerPoint = new google.maps.LatLng(23.384096, 77.497747);
        handler.fitMapToBounds();
        handler.getMap().setCenter(centerPoint);
        handler.getMap().setZoom(4);
      });
    };

    $scope.showBusStopOnMap = function() {
      address = $scope.busStop['name'] + ',' + $scope.busStop['street'] + ',' + $scope.busStop['district']  + ',India';
      handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
        markers = handler.addMarkers([
          {
            "lat": $scope.busStop['latitude'],
            "lng": $scope.busStop['longitude'],
            "infowindow": address
          }
        ]);
        centerPoint = new google.maps.LatLng($scope.busStop['latitude'], $scope.busStop['longitude']);
        handler.fitMapToBounds();
        handler.getMap().panTo(centerPoint);
        handler.getMap().setZoom(16);
      });
    };

    $scope.getLatLng = function() {
      address = $scope.busStop['name'] + ',' + $scope.busStop['street'] + ',' + $scope.busStop['district']  + ',India';
      params = {'address': address};
      $rest.setRequestSuffix('.json');
      $rest.one('bus_stops').one('lat_lng').post('', params)
      .then(function(data) {
        $scope.busStop['latitude'] = data['lat_lng']['lat'];
        $scope.busStop['longitude'] = data['lat_lng']['lng'];
        $scope.showBusStopOnMap();
      }, function() {
        alert('Error fetching lat-lng of the address');
      }
      );
    };

    $scope.getBusStop = function() {
      $rest.setRequestSuffix('.json');
      $rest.one('bus_stops', busStopId).get()
      .then(function(data) {
        $scope.busStop = data['bus_stop'];
        $scope.showBusStopOnMap();
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

    $scope.initMap();
    $scope.getStateDistrictData();
    $scope.getBusStop();
  }
]); 

