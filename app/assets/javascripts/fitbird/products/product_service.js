module.service('Product', function($http) {
  this.query = function(userId) {
    return $http({
      method: 'GET',
      url: '/api/users/'+userId+'/products.json'
    })
  };
  this.get = function(userId, productId) {
    return $http({
      method: 'GET',
      url: '/api/users/'+userId+'/products/'+productId+'.json'
    })
  };
  this.create = function(userId, product) {
    return $http({
      method: 'POST',
      url: '/api/users/'+userId+'/products.json',
      data: product
    })
  };
  this.update = function(userId, productId, product) {
    return $http({
      method: 'PATCH',
      url: '/api/users/'+userId+'/products/'+productId+'.json',
      data: product
    })
  };
  this.delete = function(userId, productId) {
    return $http({
      method: 'DELETE',
      url: '/api/users/'+userId+'/products/'+productId+'.json'
    })
  };
});
