angular.module('app', ['ngRoute']).config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        redirectTo: '/home'
      }).
      when('/home', {
        templateUrl: 'fragments/home.html',
        controller: 'AnyCtrl'
      }).
      when('/car-studio', {
        templateUrl: 'fragments/car-studio.html',
        controller: 'AnyCtrl'
      }).
      when('/product/:productId', {
        templateUrl: function(urlattr){
                return 'fragments/product-' + urlattr.productId + '.html';
            },
        controller: 'AnyCtrl',
      }).
      when('/product-not/:productId', {
        templateUrl: 'fragments/product-not.html',
        controller: 'AnyCtrl',
      }).
      when('/blog', {
        templateUrl: 'fragments/blog.html',
      }).
      otherwise({
        templateUrl: 'fragments/notfound.html',
      });
  }]);;

function AnyCtrl($scope, $routeParams)
{
	$scope.productId = $routeParams.productId;
}
function MainCtrl($scope) 
{
	$scope.model = model;
}
