module.controller('RoleToUserCtrl', ['$auth', '$scope', '$state', '$stateParams', 'RoleToUser',
  function($auth, $scope, $state, $stateParams, RoleToUser) {
    userId = $auth.user.id;

    $scope.addRole = function(roleId) {
      RoleToUser.create(userId, roleId).then(function(response) {
        }).catch(function(error) {
          $scope.error = error.data;
        });
  };
}]);
