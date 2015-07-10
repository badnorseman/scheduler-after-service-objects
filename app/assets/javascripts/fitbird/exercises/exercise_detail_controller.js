module.controller('ExerciseDetailCtrl', ['$scope', '$state', '$stateParams', 'Exercise',
  function($scope, $state, $stateParams, Exercise) {
    $scope.id = $stateParams.id;

    if ($scope.id) {
      Exercise.get({id: $scope.id}, function(response) {
        $scope.exercise = response;
      }, function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.exercise = new Exercise();
    }

    $scope.save = function() {
      if ($scope.id) {
        $scope.exercise.$update(function(response) {
          var index = $scope.exercises.indexOf($scope.exercise);
          $scope.exercises.splice(index, 1);
          $scope.exercises = $scope.exercises.push($scope.exercise);
          $state.go('exercises');
        }, function(error) {
          $scope.error = error.data;
        });
      }
      else {
        $scope.exercise.$save(function(response) {
          $scope.exercises = $scope.exercises.push($scope.exercise);
          $state.go('exercises');
        }, function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(exercise) {
      $scope.exercise.$delete(function(response) {
        var index = $scope.exercises.indexOf($scope.exercise);
        $scope.exercises.splice(index, 1);
        $state.go('exercises');
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
