module.factory('ExerciseDescription', ['$resource', function($resource)  {
  return $resource('/api/exercise_descriptions/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
