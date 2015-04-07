'use strict';

angular.module('MainController').controller('NavbarController', navbarController);

navbarController.$inject = ['AuthFactory', '$location'];

function navbarController(AuthFactory, $location) {
    var vm = this;

    vm.isLoggedIn = function() {
        return AuthFactory.isAuthenticated();
    };

    vm.logout = function() {
        AuthFactory.logout().then(function() {
            $location.path('/');
        });
    };
}
