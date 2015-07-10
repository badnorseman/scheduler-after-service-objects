module.factory('Role', ['$resource', function($resource)  {
  return $resource('/api/roles/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
