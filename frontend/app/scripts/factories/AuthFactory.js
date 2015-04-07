'use strict';

angular.module('NoshApp').factory('AuthFactory', ['$http', '$window', 'ServerUrl', function($http, $window, ServerUrl) {
    var login = function(credentials) {
        return $http.post(ServerUrl + '/users/sign_in', credentials).success(function(response) {
            _storeSession(response);
        });
    };

    var logout = function() {
        return $http.get(ServerUrl + '/users/sign_out').success(function() {
            $window.localStorage.removeItem('nc-user');
        });
    };

    var isAuthenticated = function() {
        var data = JSON.parse($window.localStorage.getItem('nc-user'));
        if(data) { return !!data.token; }
        return false;
    };

    var isAdmin = function() {
        var data = JSON.parse($window.localStorage.getItem('nc-user'));
        if(data) { return data.admin; }
        return false;
    };

    // var clearStorage = function() {};

    var _storeSession = function(data) {
        $window.localStorage.setItem('nc-user', JSON.stringify(data));
        $http.defaults.headers.common.authorization = 'Token token=' + data.token;
    };

    return {
        login: login,
        logout: logout,
        isAuthenticated: isAuthenticated,
        isAdmin: isAdmin
        // clearStorage: clearStorage
    };

}]);
