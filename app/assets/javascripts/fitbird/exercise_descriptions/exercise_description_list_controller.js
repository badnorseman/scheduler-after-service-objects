module.controller('ExerciseDescriptionListCtrl', ['$scope', 'ExerciseDescription',
  function($scope, ExerciseDescription) {
    $scope.exerciseDescriptions = ExerciseDescription.query();
}]);
