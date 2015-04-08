'use strict';

angular
    .module('NoshApp')
    .factory('ProductsFactory', ProductsFactory);


    ProductsFactory.$inject = ['$http', '$window', 'ServerUrl', '$upload'];

    function ProductsFactory($http, $window, ServerUrl, $upload) {
        var products = [];

        var addProduct = function(newProduct) {
            // user must be admin in Rails
            var file = newProduct.image;
            debugger;
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
            return $http.post(ServerUrl + '/admin/products', data, config).success(getProducts);
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

        return {
            products: products,
            getProducts: getProducts,
            addProduct: addProduct
        };
    }
