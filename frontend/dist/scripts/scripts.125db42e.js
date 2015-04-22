"use strict";function homeController(){}function loginController(a,b){var c=this;c.login=function(d){a.login(d).then(function(){c.credentials={},b.path("/")})}}function navbarController(a,b){var c=this;c.isLoggedIn=function(){return a.isAuthenticated()},c.isAdmin=function(){return a.isAdmin()},c.logout=function(){a.logout().then(function(){b.path("/")})}}function productsController(a){var b=this;b.products=a.products,b.newProduct=a.newProduct,b.addProduct=function(c){a.addProduct(c).then(function(){b.newProduct={}})},b.hasImage=function(b){return a.hasImage(b)}}angular.module("NoshApp",["ngAnimate","ngAria","ngCookies","ngMessages","ngResource","ngRoute","ngSanitize","ngTouch","MainController","MainDirective","angularFileUpload"]).run(["$rootScope","$http","$window","$location","AuthFactory","ProductsFactory",function(a,b,c,d,e,f){a.$on("$routeChangeStart",f.getProducts)}]),angular.module("NoshApp").config(["$routeProvider",function(a){a.when("/",{templateUrl:"views/home.html",controller:"HomeController"}).when("/login",{templateUrl:"views/login.html"}).when("/products",{templateUrl:"views/products.html",controller:"ProductsController",controllerAs:"productsController"}).when("/admin",{templateUrl:"views/admin/new-product-form.html",controller:"ProductsController",controllerAs:"productsController"}).when("/videos",{templateUrl:"views/videos.html"}).otherwise({redirectTo:"/"})}]),angular.module("NoshApp").constant("ServerUrl","https://dry-retreat-5402.herokuapp.com"),angular.module("NoshApp").factory("AuthFactory",["$http","$window","ServerUrl",function(a,b,c){var d=function(b){return a.post(c+"/users/sign_in",b).success(function(a){h(a)})},e=function(){return a.get(c+"/users/sign_out").success(function(){b.localStorage.removeItem("nc-user")})},f=function(){var a=JSON.parse(b.localStorage.getItem("nc-user"));return a?!!a.token:!1},g=function(){var a=JSON.parse(b.localStorage.getItem("nc-user"));return a?a.admin:!1},h=function(c){b.localStorage.setItem("nc-user",JSON.stringify(c)),a.defaults.headers.common.authorization="Token token="+c.token};return{login:d,logout:e,isAuthenticated:f,isAdmin:g}}]),angular.module("NoshApp").factory("ProductsFactory",["$http","$window","ServerUrl","$upload",function(a,b,c,d){var e,f,g=[],h=JSON.parse(b.localStorage.getItem("nc-user")),i={headers:{AUTHORIZATION:"Token token="+h.token}},j="https://s3.amazonaws.com/nosh-cookie-co/",k=function(a){var b=a.type.replace(/[%&\/#"\\]/g,function(a){return'"'===a||"\\"===a?" ":"%"+a.charCodeAt(0).toString(16)});return b},l=function(a){f=a.key,d.upload({url:j,type:"POST",fields:{key:a.key,AWSAccessKeyId:a.access_key,policy:a.policy,signature:a.signature,"Content-Type":""===e.type?"application/octet-stream":e.type},file:e})},m=function(b){return a.post(c+"/admin/products",b,i)},n=function(b){return a.get(c+"/amazon/sign_key/"+b)},o=function(a){var b={product:{name:a.name,description:a.description,price:a.price}};if(a.image){e=a.image[0];var c=k(e);return n(c).success(l).then(function(){b.product.image_url=j+f,m(b)})}return m(b)},p=function(){return a.get(c+"/products").success(function(a){angular.copy(a,g)}).error(function(a,b,c,d){console.log("Something's amiss: ",a,b,c,d)})},q=function(a){return null!==a.image_url};return{products:g,getProducts:p,addProduct:o,hasImage:q}}]),angular.module("MainController",[]),angular.module("MainController").controller("HomeController",homeController),homeController.$inject=[],angular.module("MainController").controller("LoginController",loginController),loginController.$inject=["AuthFactory","$location"],angular.module("MainController").controller("NavbarController",navbarController),navbarController.$inject=["AuthFactory","$location"],angular.module("MainController").controller("ProductsController",productsController),productsController.$inject=["ProductsFactory"],angular.module("MainDirective",[]),angular.module("MainDirective").directive("loginForm",[function(){return{restrict:"E",templateUrl:"views/login-form.html",controller:"LoginController",controllerAs:"loginController",bindToController:!0,scope:{credentials:"="}}}]),angular.module("MainController").directive("ncNavbar",[function(){return{restrict:"E",templateUrl:"views/navbar.html",controller:"NavbarController",controllerAs:"navbarController",bindToController:!0,scope:{}}}]);