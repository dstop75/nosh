'use strict';

/**
 * @ngdoc overview
 * @name frontendApp
 * @description
 * # frontendApp
 *
 * Main module of the application.
 */
angular
    .module('NoshApp', [
        'ngAnimate',
        'ngAria',
        'ngCookies',
        'ngMessages',
        'ngResource',
        'ngRoute',
        'ngSanitize',
        'ngTouch',
        'MainController',
        'MainDirective'
        ])
    .run(function($rootScope, $http, $window, $location, AuthFactory, ProductsFactory) {
        if (AuthFactory.isAuthenticated()) {
            var data = JSON.parse($window.localStorage.getItem('nc-user'));
            $http.defaults.headers.common.Authorization = 'Token token=' + data.token;
        } else {
            $location.path('/login');
        }

        $rootScope.$on('$routeChangeStart', function() {
            if(!AuthFactory.isAuthenticated()) {
                $location.path('/login');
            } else {
                ProductsFactory.getProducts();
            }
        });
    });
