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

        $rootScope.$on('$routeChangeStart', ProductsFactory.getProducts);
    });
