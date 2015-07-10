module.factory('Exercise', ['$resource', function($resource)  {
  return $resource('/api/exercise/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
