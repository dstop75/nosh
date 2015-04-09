'use strict';

angular
    .module('MainController')
    .controller('ProductsController', productsController);

    productsController.$inject = ['ProductsFactory', '$location'];

    function productsController(ProductsFactory, $location) {
        var vm = this;
        vm.products = ProductsFactory.products;
        vm.newProduct = ProductsFactory.newProduct;

        vm.addProduct = function(newProduct) {
            ProductsFactory.addProduct(newProduct).then(function() {
                vm.newProduct = {};
            });
        };

        vm.hasImage = function(product) {
            return ProductsFactory.hasImage(product);
        };
    }
