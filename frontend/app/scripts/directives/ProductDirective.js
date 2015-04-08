'use strict';
angular
    .module('MainDirective')
    .directive('newProductForm' [function() {
        return {
            restrict: 'E',
            templateUrl: 'views/admin/new-product-form.html',
            controller: 'ProductsController',
            controllerAs: 'productsController',
            bindToController: true,
            scope: {
                newProduct: '='
            }
        };
    }]);
