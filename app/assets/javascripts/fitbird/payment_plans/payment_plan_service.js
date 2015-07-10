module.factory('PaymentPlan', ['$resource', function($resource)  {
  return $resource('/api/payment_plans/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
