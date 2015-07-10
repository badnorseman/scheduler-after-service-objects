module.service('RoleToUser', function($http) {
  this.create = function(userId, roleId) {
    return $http({
      method: 'POST',
      url: '/api/users/'+userId+'/roles/'+roleId+'.json',
    })
  };
});
