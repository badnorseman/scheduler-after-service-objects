module.factory('Habit', ['$resource', function($resource)  {
  return $resource('/api/habits/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
