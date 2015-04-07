'use strict';

angular.module('MainController').controller('ProductsController', productsController);

productsController.$inject = ['ProductsFactory'];

function productsController(ProductsFactory) {
    var vm = this;
    vm.products = ProductsFactory.products;
}
