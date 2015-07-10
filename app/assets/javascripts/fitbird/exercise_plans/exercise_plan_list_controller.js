module.controller('ExercisePlanListCtrl', ['$scope', 'ExercisePlan',
  function($scope, ExercisePlan) {
    $scope.exercisePlans = ExercisePlan.query();
}]);
