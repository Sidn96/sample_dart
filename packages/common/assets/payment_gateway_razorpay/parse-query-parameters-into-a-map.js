/**
 * Get a query map based on a query string.
 *
 * The function will populate a map variable with key value pairs of the parameters.
 *
 * If there is more than one of the same key, the function will populate an array in the map with the multiple values within it
 * 
 * @param  {string} query The query string - the question mark is optional
 * @return {object}       key value pairs of the parameter / value of the parameter
 */
function getQueryMap(query) {
    if(typeof query !== 'string') {
      return null;
    }
    
    var toType = function(a) {
      return ({}).toString.call(a).match(/\s([a-zA-Z]+)/)[1].toLowerCase();
    }, map = {};
    
  // map the hit query into a proper object
  query.replace(/([^&|\?=]+)=?([^&]*)(?:&+|$)/g, function (match, key, value) {
      if (key in map) {
          // the key already exists, so we need to check if it is an array, if not, make it an array and add the new value
          if (toType(map[key]) !== 'array') {
              // it's not an array - make it an array
              map[key] = [map[key]];
          }
          // push the new value into the array
          map[key].push(value);
      } else {
          // put the value into the map
          map[key] = value;
      }
  });
  return map;
}