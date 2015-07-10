module.controller('HabitListCtrl', ['$scope', 'Habit',
  function($scope, Habit) {
    $scope.habits = Habit.query();
}]);
