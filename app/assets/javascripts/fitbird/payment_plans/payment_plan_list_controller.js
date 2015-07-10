module.controller('PaymentPlanListCtrl', ['$scope', 'PaymentPlan',
  function($scope, PaymentPlan) {
    $scope.paymentPlans = PaymentPlan.query();
}]);
