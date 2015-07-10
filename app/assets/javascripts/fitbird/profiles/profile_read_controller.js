module.controller('ProfileReadCtrl', ['$auth', '$scope', 'Profile',
  function($auth, $scope, Profile) {
    Profile.get({id: $auth.user.id}, function(response) {
      $scope.profile = response;
    }, function(error) {
      $scope.error = error.data;
    });
}]);
