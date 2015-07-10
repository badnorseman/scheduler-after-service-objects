module.factory('Inceptor', ['$injector', '$q',
  function($injector, $q)  {
    return {
      'response': function(response) {
        return response;
      },
      'responseError': function(error) {
        if (error.status == 401 || error.status == 403 || error.status == 404) {
          return error;
        }
        return $q.reject(error);
      }
    };
}]);
module.config(['$httpProvider', function($httpProvider) {
  $httpProvider.interceptors.push('Inceptor')
}]);
// module.config(function($httpProvider) {
//     $httpProvider.interceptors.push(function($q) {
//       return {
//         'response': function(data) {
//           return data;
//         },
//         'responseError': function(error) {
//           if (error.status == 401 || error.status == 403 || error.status == 404) {
//             return error;
//           }
//           return $q.reject(error);
//         }
//       };
//     });
// });
