app = angular.module('busApp', ['ui.bootstrap', 'restangular', 'ngGrid', 'ui.select', 'ngSanitize']);

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

