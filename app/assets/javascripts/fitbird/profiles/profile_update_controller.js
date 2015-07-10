module.controller('ProfileUpdateCtrl', ['$auth', '$scope', 'Profile',
  function($auth, $scope, Profile) {
    $scope.updateProfile = function() {
      $scope.profile.$update({id: $auth.user.id}, function(response) {
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
