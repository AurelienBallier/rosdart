part of rosdart;

String _caller_id = '/dart_client';
String _uri = 'http://localhost:11311';

void set URI(String uri){
  _uri = uri;
}

String get URI => _uri;

void set caller_id(String caller_id){
  _caller_id = caller_id;
}

String get caller_id => _caller_id;
