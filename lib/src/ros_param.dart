part of rosdart;

class Param {  
  //Constructor
  Param();
  
  Future<bool> SetParam(String key, String val){  
    var _request = new RpcRequest(); 
    _request.method = 'setParam';
    _request.addParam(caller_id);
    _request.addParam(key);
    _request.addParam(val);

    return http
        .post(URI, body: _request.toString())
        .then((httpResponse) {
            var response = new RpcResponse.fromText(httpResponse.body);
            
            return (response.isSuccess && (response[0][0] == 1));
        });
    
  }
  
  Future<String> GetParam(String key){  
    var _request = new RpcRequest(); 
    _request.method = 'getParam';
    _request.addParam(caller_id);
    _request.addParam(key);

    return http
        .post(URI, body: _request.toString())
        .then((httpResponse) {
            var response = new RpcResponse.fromText(httpResponse.body);
            
            if(response.isSuccess && (response[0][0] == 1)){
              return response[0][2];
            }
            
            return '';
        });
    
  }
  
}