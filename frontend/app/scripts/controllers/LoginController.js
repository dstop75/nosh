'use strict';

function loginController(AuthFactory, $location) {
    var vm = this;

    vm.login = function(credentials) {
        AuthFactory.login(credentials).then(function() {
            vm.credentials = {};
            $location.path('/');
        });
    };
}

angular
    .module('MainController')
    .controller('LoginController', loginController);

    loginController.$inject = ['AuthFactory', '$location'];
