module.controller('PaymentPlanDetailCtrl', ['$scope', '$state', '$stateParams', 'PaymentPlan',
  function($scope, $state, $stateParams, PaymentPlan) {
    $scope.id = $stateParams.id;

    if ($scope.id) {
      PaymentPlan.get({id: $scope.id}, function(response) {
        $scope.paymentPlan = response;
      }, function(error) {
        $scope.error = error.data;
      });
    } else {
      $scope.paymentPlan = new PaymentPlan();
    }

    $scope.save = function() {
      if ($scope.id) {
        $scope.paymentPlan.$update(function(response) {
          var index = $scope.paymentPlans.indexOf($scope.paymentPlan);
          $scope.paymentPlans.splice(index, 1);
          $scope.paymentPlans = $scope.paymentPlans.push($scope.paymentPlan);
          $state.go('paymentPlans');
        }, function(error) {
          $scope.error = error.data;
        });
      }
      else {
        $scope.paymentPlan.$save(function(response) {
          $scope.paymentPlans = $scope.paymentPlans.push($scope.paymentPlan);
          $state.go('paymentPlans');
        }, function(error) {
          $scope.error = error.data;
        });
      }
    };

    $scope.delete = function(paymentPlan) {
      $scope.paymentPlan.$delete(function(response) {
        var index = $scope.paymentPlans.indexOf($scope.paymentPlan);
        $scope.paymentPlans.splice(index, 1);
        $state.go('paymentPlans');
      }, function(error) {
        $scope.error = error.data;
      });
    };
}]);
