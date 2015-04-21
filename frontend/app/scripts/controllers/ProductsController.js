'use strict';

function productsController(ProductsFactory) {
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

angular
    .module('MainController')
    .controller('ProductsController', productsController);

    productsController.$inject = ['ProductsFactory'];
