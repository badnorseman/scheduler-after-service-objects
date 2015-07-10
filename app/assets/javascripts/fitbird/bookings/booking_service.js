module.factory('Booking', ['$resource', function($resource)  {
  return $resource('/api/bookings/:id.json', {id:'@id'}, {
    'query': {method: 'GET', isArray: true}
  });
}]);
