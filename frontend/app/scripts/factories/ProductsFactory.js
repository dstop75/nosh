'use strict';

angular
    .module('NoshApp')
    .factory('ProductsFactory', ['$http', '$window', 'ServerUrl', '$upload', function($http, $window, ServerUrl, $upload) {
        var products = [],
            user,
            railsConfig,
            file,
            suffix,
            awsUrl = 'https://s3.amazonaws.com/nosh-cookie-co/';

        var getUser = function() {
            return JSON.parse($window.localStorage.getItem('nc-user'));
        };

        var configRails = function() {
            user = getUser();
            return {
                headers: {
                    'AUTHORIZATION': 'Token token=' + user.token
                }
            };
        };

        var urlify = function (file) {
            var ready = file.type.replace(/[%&\/#"\\]/g, function(m) {
                    return (m === '"' || m === '\\') ? ' ' : '%' + m.charCodeAt(0).toString(16);
                });
            return ready;
        };

        var sendToAWS = function(response) {
            suffix = response.key;
            $upload.upload({
                url: awsUrl,
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
        };

        var sendToRails = function(data) {
            railsConfig = configRails();
            return $http.post(ServerUrl + '/admin/products', data, railsConfig);
        };

        var getAWSsignKey = function(urlReady) {
            return $http.get(ServerUrl + '/amazon/sign_key/' + urlReady);
        };

        var addProduct = function(newProduct) {
            var data = {
                product: {
                    name: newProduct.name,
                    description: newProduct.description,
                    price: newProduct.price
                }
            };

            if (newProduct.image) {
                file = newProduct.image[0];
                var urlReady = urlify(file);
                return getAWSsignKey(urlReady)
                .success(sendToAWS)
                .then(function() {
                    data.product.image_url = awsUrl + suffix;
                    sendToRails(data);
                });
            } else {
                return sendToRails(data);
            }
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
