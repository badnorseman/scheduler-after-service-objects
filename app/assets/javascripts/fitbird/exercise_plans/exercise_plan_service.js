module.factory('ExercisePlan', ['$resource', function($resource)  {
  return $resource('/api/exercise_plans/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
