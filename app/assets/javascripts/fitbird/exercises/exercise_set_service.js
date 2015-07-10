module.factory('ExerciseSet', ['$resource', function($resource)  {
  return $resource('/api/exercise_sets/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
