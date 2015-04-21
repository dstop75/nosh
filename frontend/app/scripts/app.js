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
        'MainDirective',
        'angularFileUpload'
        ])
    .run(function($rootScope, $http, $window, $location, AuthFactory, ProductsFactory) {
        if (AuthFactory.isAuthenticated()) {
            var data = JSON.parse($window.localStorage.getItem('nc-user'));
        }

        $rootScope.$on('$routeChangeStart', ProductsFactory.getProducts);
    });
