'use strict';

angular.module('NoshApp').config(['$routeProvider', function($routeProvider) {
    $routeProvider
        .when('/', {
            templateUrl: 'views/home.html',
            controller: 'HomeController'
        })
        .when('/login', {
            templateUrl: 'views/login.html'
        })
        .when('/products', {
            templateUrl: 'views/products.html',
            controller: 'ProductsController',
            controllerAs: 'productsController'
        })
        .when('/admin', {
            templateUrl: 'views/admin/product-form.html'
        })
        .otherwise({
            redirectTo: '/'
        });
}]);
