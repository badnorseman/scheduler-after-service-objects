module.controller('HabitDetailCtrl', ['$scope', '$state', '$stateParams', 'Habit',
  function($scope, $state, $stateParams, Habit) {
    $scope.id = $stateParams.id;

    if ($scope.id) {
      Habit.get({id: $scope.id}, function(response) {
        $scope.habit = response;
      }, function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.habit = new Habit();
    };

    $scope.save = function() {
      if ($scope.id) {
        $scope.habit.$update(function(response) {
          var index = $scope.habits.indexOf($scope.habit);
          $scope.habits.splice(index, 1);
          $scope.habits = $scope.habits.push($scope.habit);
          $state.go('habits');
        }, function(error) {
          $scope.error = error.data;
        });
      }
      else {
        $scope.habit.$save(function(response) {
          $scope.habits = $scope.habits.push($scope.habit);
          $state.go('habits');
        }, function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(habit) {
      $scope.habit.$delete(function(response) {
        var index = $scope.habits.indexOf($scope.habit);
        $scope.habits.splice(index, 1);
        $state.go('habits');
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
