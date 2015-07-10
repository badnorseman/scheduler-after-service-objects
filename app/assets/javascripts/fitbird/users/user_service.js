module.factory('User', ['$resource', function($resource)  {
  return $resource('/api/users/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true}
  });
}]);
