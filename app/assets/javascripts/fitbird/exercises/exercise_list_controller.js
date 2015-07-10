module.controller('ExerciseListCtrl', ['$scope', 'Exercise',
  function($scope, Exercise) {
    $scope.exercises = Exercise.query();
}]);
