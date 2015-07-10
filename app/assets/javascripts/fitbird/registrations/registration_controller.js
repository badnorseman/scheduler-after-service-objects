module.controller('RegistrationCtrl', ['$auth', '$scope', '$state', '$stateParams', 'Profile', 'RoleToUser',
  function($auth, $scope, $state, $stateParams, Profile, RoleToUser) {
    $scope.profile = new Profile();
    $scope.roleToUser = new RoleToUser();
    var roleId = $stateParams.roleId;

    $scope.submitRegistrationOAuth = function(provider) {
      $auth.authenticate(provider)
      .then(function(response) {
        $scope.profile.first_name = response.name;
        $scope.profile.last_name = '';

        roleToUser();
      })
      .catch(function(error) {
        $scope.error = error.errors[0];
      });
    };

    $scope.submitRegistration = function() {
      $scope.profile.first_name = $scope.registration.first_name;
      $scope.profile.last_name = $scope.registration.last_name;

      $auth.submitRegistration($scope.registration)
        .then(function(response) {
          $auth.submitLogin({
            email: $scope.registration.email,
            password: $scope.registration.password})
          .then(function(response) {
            roleToUser();
          })
          .catch(function(error) {
            $scope.error = error.errors[0];
          });
        })
        .catch(function(error) {
          $scope.error = error.errors[0];
        });
    };

    roleToUser = function() {
      $scope.roleToUser.$save({id: $auth.user.id, role_id: roleId}, function(response) {
        profile();
      }, function(error) {
        $scope.error = error.data;
      });
    };

    profile = function() {
      $scope.profile.$save({id: $auth.user.id}, function(response) {
        dashboard();
      }, function(error) {
        $scope.error = error.data;
      });
    };

    dashboard = function() {
      if (roleId == 2) {
        $state.go('dashboard');
      }
      if (roleId == 3) {
        $state.go('dashboardUser');
      }
    };
}]);
