module.controller('ProductDetailCtrl', ['$auth', '$scope', '$state', '$stateParams', 'Product',
  function($auth, $scope, $state, $stateParams, Product) {
    planId = $stateParams.id;
    userId = $auth.user.id;

    if (planId) {
      Product.get(userId, planId).then(function(response) {
        $scope.product = response.data;
      }).catch(function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.product = {};
    };

    $scope.save = function() {
      if (planId) {
        Product.update(userId, planId, $scope.product).then(function(response) {
          var index = $scope.products.indexOf($scope.product);
          $scope.products.splice(index, 1);
          $scope.products = $scope.products.push(response.data);
          $state.go('products');
        }).catch(function(error) {
          $scope.error = error.data;
        });
      }
      else {
        Product.create(userId, $scope.product).then(function(response) {
          $scope.products = $scope.products.push(response.data);
          $state.go('products');
        }).catch(function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(product) {
      Product.delete(userId, planId).then(function(response) {
        var index = $scope.products.indexOf($scope.product);
        $scope.products.splice(index, 1);
        $state.go('products');
      }).catch(function(error) {
        $scope.error = error.data;
      });
    };
}]);
