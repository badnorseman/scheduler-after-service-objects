module.controller('ExerciseDescriptionDetailCtrl', ['$scope', '$state', '$stateParams', 'ExerciseDescription',
  function($scope, $state, $stateParams, ExerciseDescription) {
    $scope.id = $stateParams.id;

    if ($scope.id) {
      ExerciseDescription.get({id: $scope.id}, function(response) {
        $scope.exerciseDescription = response;
      }, function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.exerciseDescription = new ExerciseDescription();
    }

    $scope.save = function() {
      if ($scope.id) {
        $scope.exerciseDescription.$update(function(response) {
          var index = $scope.exerciseDescriptions.indexOf($scope.exerciseDescription);
          $scope.exerciseDescriptions.splice(index, 1);
          $scope.exerciseDescriptions = $scope.exerciseDescriptions.push($scope.exerciseDescription);
          $state.go('exerciseDescriptions');
        }, function(error) {
          $scope.error = error.data;
        });
      }
      else {
        $scope.exerciseDescription.$save(function(response) {
          $scope.exerciseDescriptions = $scope.exerciseDescriptions.push($scope.exerciseDescription);
          $state.go('exerciseDescriptions');
        }, function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(exerciseDescription) {
      $scope.exerciseDescription.$delete(function(response) {
        var index = $scope.exerciseDescriptions.indexOf($scope.exerciseDescription);
        $scope.exerciseDescriptions.splice(index, 1);
        $state.go('exerciseDescriptions');
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
