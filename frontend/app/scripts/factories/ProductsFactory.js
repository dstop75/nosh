'use strict';

angular.module('NoshApp').factory('ProductsFactory', ['$http', '$window', 'ServerUrl', function($http, $window, ServerUrl) {
    var products = [];

    var addProduct = function(newProduct) {
        // user must be admin in Rails
        var user = JSON.parse($window.localStorage.getItem('nc-user'));
        var config = {
            headers: {
                'AUTHORIZATION': 'Token token=' + user.token
            }
        };

        var data = {
            product: {
                name: newProduct.name,
                description: newProduct.description,
                price: newProduct.price
            }
        };
        return $http.post(ServerUrl + '/admin/products', data, config).success(function() {
            getProducts();
        });
    };

    var getProducts = function() {
        return $http.get(ServerUrl + '/products')
        .success(function(response) {
            angular.copy(response, products);
        })
        .error(function(data, status, headers, config) {
            console.log('Something\'s amiss: ', data, status, headers, config);
        });
    };

    // var getProducts = function() {
    //     var data = JSON.parse($window.localStorage.getItem('nc-user'));
    //     var config = {
    //         headers: {
    //             'AUTHORIZATION': 'Token token=' + data.token
    //         }
    //     };
    //     return $http.get(ServerUrl + '/products', config).success(function(response) {
    //         angular.copy(response, products);
    //     }).error(function(data, status, headers, config) {
    //         console.log('Something\'s amiss: ', data, status, headers, config);
    //     });
    // };

    return {
        products: products,
        getProducts: getProducts,
        addProduct: addProduct
    };
}]);
