module.controller('ExercisePlanDetailCtrl', ['$scope', '$state', '$stateParams', 'ExercisePlan',
  function($scope, $state, $stateParams, ExercisePlan) {
    $scope.id = $stateParams.id;

    if ($scope.id) {
      ExercisePlan.get({id: $scope.id}, function(response) {
        $scope.exercisePlan = response;
      }, function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.exercisePlan = new ExercisePlan();
    }

    $scope.save = function() {
      if ($scope.id) {
        $scope.exercisePlan.$update(function(response) {
          var index = $scope.exercisePlans.indexOf($scope.exercisePlan);
          $scope.exercisePlans.splice(index, 1);
          $scope.exercisePlans = $scope.exercisePlans.push($scope.exercisePlan);
          $state.go('exercisePlans');
        }, function(error) {
          $scope.error = error.data;
        });
      }
      else {
        $scope.exercisePlan.$save(function(response) {
          $scope.exercisePlans = $scope.exercisePlans.push($scope.exercisePlan);
          $state.go('exercisePlans');
        }, function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(exercisePlan) {
      $scope.exercisePlan.$delete(function(response) {
        var index = $scope.exercisePlans.indexOf($scope.exercisePlan);
        $scope.exercisePlans.splice(index, 1);
        $state.go('exercisePlans');
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
