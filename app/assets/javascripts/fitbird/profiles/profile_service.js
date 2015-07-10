module.factory('Profile', ['$resource', function($resource)  {
  return $resource('/api/users/:id/profile.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true},
    'update': {method:'PUT'}
  });
}]);
