'use strict';

function navbarController(AuthFactory, $location) {
    var vm = this;

    vm.isLoggedIn = function() {
        return AuthFactory.isAuthenticated();
    };

    vm.isAdmin = function() {
        return AuthFactory.isAdmin();
    };

    vm.logout = function() {
        AuthFactory.logout().then(function() {
            $location.path('/');
        });
    };
}

angular
    .module('MainController')
    .controller('NavbarController', navbarController);

    navbarController.$inject = ['AuthFactory', '$location'];
