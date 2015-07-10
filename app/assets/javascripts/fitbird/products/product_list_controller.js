module.controller('ProductListCtrl', ['$auth', '$scope', 'Product',
  function($auth, $scope, Product) {
    userId = $auth.user.id;

    $scope.products = [];

    Product.query(userId).then(function(response) {
        $scope.products = response.data;
      }).catch(function(error) {
        $scope.error = error.data;
      });
}]);
