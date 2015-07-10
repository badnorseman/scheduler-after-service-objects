module.controller('LogoutCtrl', ['$auth', '$scope', '$state',
  function($auth, $scope, $state) {
    $auth.signOut()
      .then(function(response) {
        $state.go('welcome');
      })
      .catch(function(error) {
        $scope.error = error.errors[0];
      });
}]);
