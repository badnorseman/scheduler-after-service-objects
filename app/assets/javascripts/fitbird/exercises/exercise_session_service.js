module.factory('ExerciseSession', ['$resource', function($resource)  {
  return $resource('/api/exercise_sessions/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
