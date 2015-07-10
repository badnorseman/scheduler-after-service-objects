module.controller('DashboardUserCtrl', ['$auth', '$scope',
  function($auth, $scope) {
    $scope.user.email = $auth.user.email;
    $scope.user.signedIn = $auth.user.signedIn;
}]);
