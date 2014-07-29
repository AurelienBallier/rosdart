part of rosdart;

class Master {    
    //Data
    Map<String, List<String>> _publishers = {};
    Map<String, List<String>> _subscribers = {};
    Map<String, List<String>> _services = {};
    
    //Constructor
    Master();
    
    //Data getter
    Map<String, List<String>> get publishers => _publishers;
    Map<String, List<String>> get subscribers => _subscribers;
    Map<String, List<String>> get services => _services;
    
    //Update system state
    Future<bool> _update_system_state(){
      var _request = new RpcRequest();       
      _request.method = 'getSystemState';
      _request.addParam(caller_id);

      return http
          .post(URI, body: _request.toString())
          .then((httpResponse) {
              var response = new RpcResponse.fromText(httpResponse.body);

              if(response.isSuccess && (response[0][0] == 1)){
                //Clean data
                _publishers.clear();
                _subscribers.clear();
                _services.clear();
                
                //Publishers
                response[0][2][0].forEach((topic){
                  topic[1].forEach((publisher){
                    if(!_publishers.containsKey(publisher)){
                        _publishers[publisher] = [];
                    }
                        
                    publishers[publisher].add(topic[0]);
                  });
                });
                
                //Subscribers
                response[0][2][1].forEach((topic){
                  topic[1].forEach((subscriber){
                    if(!_subscribers.containsKey(subscriber)){
                      _subscribers[subscriber] = [];
                    }
                        
                    _subscribers[subscriber].add(topic[0]);
                  });
                });
                
                //Services
                response[0][2][2].forEach((service){
                  service[1].forEach((publisher){
                    if(!_services.containsKey(publisher)){
                      _services[publisher] = [];
                    }
                        
                    _services[publisher].add(service[0]);
                  });
                });
                
                return true;
              }
              return false;
          });
    }
    
    Future<bool> update(){
      return _update_system_state();
    }
}