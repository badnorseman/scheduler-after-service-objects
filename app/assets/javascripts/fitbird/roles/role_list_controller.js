module.controller('RoleListCtrl', ['$scope', 'Role',
  function($scope, Role) {
    $scope.roles = Role.query();
}]);
