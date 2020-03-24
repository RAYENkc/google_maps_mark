import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FireMap(),
    );
  }
}


 class FireMap extends StatefulWidget {
   
   @override
   _FireMapState createState() => _FireMapState();
 }
 
 const LatLng _kMapCenter = LatLng(36.846392793207926, 10.203421178010922);
 class _FireMapState extends State<FireMap> {
   GoogleMapController mapController;
  //Completer<GoogleMapController> mapController = Completer();
   BitmapDescriptor _markerIcon;
  LatLng _lastMapPostion = _kMapCenter;
  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};


   @override
   Widget build(BuildContext context) {
     return Stack(
       children: <Widget>[
         GoogleMap(
           initialCameraPosition: CameraPosition(
             target: _kMapCenter ,
             zoom: 10.0,
             ),
            onMapCreated: _onMapCreated,
            mapType: _currentMapType,
            myLocationEnabled: true,
            compassEnabled: true,
            markers: _markers,
            onCameraMove : _onCameraMove,
            
         ),
         Padding(
           padding: EdgeInsets.all(16.0),
           child: Align(
               alignment: Alignment.topRight,
               child: Column(
               children: <Widget>[
                 button(
                   _onMapTypeButtonPressed, 
                   Icons.map),
                 SizedBox(height: 16.0,),
                 button(_onAddMarkerButtonPressed, Icons.add_location),
                 SizedBox(height: 16.0,),
                 button(_goToPosition1, Icons.location_searching)
               ]
           ),
           ),
           ),
        /* Positioned(
           bottom:50,
           right:10,
           child: 
           FlatButton(
             onPressed: _addMarker,
             color: Colors.white,
            child: Icon(Icons.pin_drop,color: Colors.white,)
            ),*/
         
       ],
       
     );
   }
     _onMapCreated(GoogleMapController controller){
    setState(() {
     // mapController.complete(controller);
     mapController = controller;
      
    });
  }
 /*Set<Marker> _createMarker(){
   return <Marker>[
     Marker(
     markerId: MarkerId("marker_1"),
     position: _kMapCenter,
     icon:  _markerIcon,
     ),
   ].toSet();
 }
  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/red_square.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }*/

static final CameraPosition _position1 = CameraPosition(
     bearing: 192.833,
     target: LatLng(36.856392793207926, 10.213421178010922),
     tilt: 59.440,
     zoom: 11.0,
);

Future<Void> _goToPosition1() async{
  //final GoogleMapController controller = await mapController.future;
  GoogleMapController mapController;
  mapController.animateCamera(CameraUpdate.newCameraPosition(_position1));
}
 _onCameraMove(CameraPosition position){
   _lastMapPostion = position.target;
 }

Widget button(Function function, IconData icon){
  return FloatingActionButton(
    onPressed: function,
    materialTapTargetSize:  MaterialTapTargetSize.padded,
    backgroundColor: Colors.blue,
    child: Icon(
      icon,
      size:36.0
      ),
  );
}


_onMapTypeButtonPressed(){
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ? MapType.satellite: MapType.normal ;
    });
}
_onAddMarkerButtonPressed(){
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastMapPostion.toString()),
          position: _lastMapPostion,
          infoWindow: InfoWindow(
            title: 'this is a Title',
            snippet: 'this is a snippet',
            ),
          icon:  BitmapDescriptor.defaultMarker,
      ));
    });
}
 }

