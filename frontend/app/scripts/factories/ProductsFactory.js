'use strict';

angular
    .module('NoshApp')
    .factory('ProductsFactory', ['$http', '$window', 'ServerUrl', '$upload', function($http, $window, ServerUrl, $upload) {
        var products = [];

        var addProduct = function(newProduct) {
            var suffix,
            file = newProduct.image[0],
            user = JSON.parse($window.localStorage.getItem('nc-user')),
            railsConfig = {
                headers: {
                    'AUTHORIZATION': 'Token token=' + user.token
                }
            },
            urlReady = file.type.replace(/[%&\/#"\\]/g, function(m) {
                return (m === '"' || m === '\\') ? ' ' : '%' + m.charCodeAt(0).toString(16);
            });

            return $http.get(ServerUrl + '/amazon/sign_key/' + urlReady)
            .success(function(response) {
                suffix = response.key;
                $upload.upload({
                    url: 'https://s3.amazonaws.com/nosh-cookie-co',
                    type: 'POST',
                    fields: {
                        key: response.key,
                        AWSAccessKeyId: response.access_key,
                        policy: response.policy,
                        signature: response.signature,
                        'Content-Type': file.type === '' ? 'application/octet-stream' : file.type
                    },
                    file: file
                });
            })
            .then(function() {
                var data = {
                    product: {
                        name: newProduct.name,
                        description: newProduct.description,
                        price: newProduct.price,
                        image_url: 'https://s3.amazonaws.com/nosh-cookie-co/' + suffix
                    }
                };
                $http.post(ServerUrl + '/admin/products', data, railsConfig);
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

        var hasImage = function(product) {
            return product.image_url !== null;
        };

        return {
            products: products,
            getProducts: getProducts,
            addProduct: addProduct,
            hasImage: hasImage
        };
    }]);
