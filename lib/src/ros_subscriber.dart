part of rosdart;

class Subscriber {
  //Stored variables
  String _topic, _type, _server_uri;
  Function _callback;
  
  //Constructor
  Subscriber(String topic, String type, Function callback){
    _topic = topic;
    _type = type;
    _callback = callback;
    
    var _request = new RpcRequest(); 
    _request.method = 'registerSubscriber';
    _request.addParam(caller_id);
    _request.addParam(topic);
    _request.addParam(type);
    _request.addParam('http://localhost/test');//caller_id + topic

    http
        .post(URI, body: _request.toString())
        .then((httpResponse) {
            var response = new RpcResponse.fromText(httpResponse.body);
            
            if(response.isSuccess && (response[0][0] == 1)){
              _server_uri = response[0][2][0];
              callback(_server_uri);
            }
        });
    
  }
}