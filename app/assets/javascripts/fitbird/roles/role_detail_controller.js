module.controller('RoleDetailCtrl', ['$scope', '$state', '$stateParams', 'Role',
  function($scope, $state, $stateParams, Role) {
    $scope.id = $stateParams.id;

    if ($scope.id) {
      Role.get({id: $scope.id}, function(response) {
        $scope.role = response
      }, function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.role = new Role();
    };

    $scope.save = function() {
      if ($scope.id) {
        $scope.role.$update(function(response) {
          var index = $scope.roles.indexOf($scope.role);
          $scope.roles.splice(index, 1);
          $scope.roles = $scope.roles.push($scope.role);
          $state.go('roles');
        }, function(error) {
          $scope.error = error.data;
        });
      }
      else {
        $scope.role.$save(function(response) {
          $scope.roles = $scope.roles.push($scope.role);
          $state.go('roles');
        }, function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(role) {
      $scope.role.$delete(function(response) {
        var index = $scope.roles.indexOf($scope.role);
        $scope.roles.splice(index, 1);
        $state.go('roles');
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
