import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trackernity_watcher/app/constants.dart';
import 'package:trackernity_watcher/app/data/models/location_data_realtime_model.dart';
import 'package:trackernity_watcher/app/modules/home/controllers/home_controller.dart';

class StreamSocket{

  StreamSocket._internal();

  static final StreamSocket _streamSocket = StreamSocket._internal();

  factory StreamSocket(){
    return _streamSocket;
  }

  final _socketResponse= StreamController<LocationDataRealtime>.broadcast();

  void Function(LocationDataRealtime) get addResponse => _socketResponse.sink.add;

  Stream<LocationDataRealtime> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();
IO.Socket socket = IO.io(ConstantClass.baseUrlConstant,
    OptionBuilder()
        .setTransports(['websocket']).build());

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen(){

  socket.onConnect((_) {
    // print('connect');
    socket.emit('user_status', 'Connected');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('location_data', (data) {
    var locationData = LocationDataRealtime.fromJson(data);
    // print("test data incoming: ${locationData}");
    streamSocket.addResponse(locationData);
  });
  socket.onDisconnect((_) => log('disconnect'));

}

void disconnectSocket(callback){
  socket.disconnect();
  callback();
}

void connectSocket(callback){
  socket.connect();
  callback();
}
