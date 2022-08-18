import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/features/auth/sender/screens/add_delivery_request__screen.dart';
import 'package:gocolis/features/auth/traveler/screens/add_ride_request.dart';
import 'package:gocolis/models/map_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map-origin';
  final String addressFrom;
  const MapScreen({Key? key, required this.addressFrom}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String addressFrom = '';
  /*void navigateToAddDeliveryRequestScreen() {
    Navigator.pushNamed(context, AddDeliveryRequestScreen.routeName);
  }*/

  void navigateToAddRideRequestScreen() {
    Navigator.pushNamed(context, AddRide.routeName);
  }

  static const _initialCameraPosition = CameraPosition(
    // target: LatLng(36.806389, -112.181667),
    target: LatLng(35.77799, 10.82617),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  late Marker _origin = const Marker(
    markerId: MarkerId('origin'),
    position: LatLng(35.77799, 10.82617),
  );

  /*late Marker _destination = const Marker(
    markerId: MarkerId('destination'),
    position: LatLng(35.821430, 10.634422),
  );*/

  //here added ------------------------------------------------------------------------------------------------
  //List<Placemark> placemarks = [];

  // await placemarkFromCoordinates(position.latitude, position.longitude);

//Placemark place1 = placemarks[0];
//Placemark place2 = placemarks[1];
/*String _currentAddress =
            "${place1.name} ${place2.name} ${place1.subLocality} 
${place1.subAdministrativeArea} ${place1.postalCode}";*/

  Directions? info;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: const Text('Google Maps'),
          backgroundColor: kPrimaryLightColor,
          actions: [
            //if (_origin != null)
              TextButton(
                onPressed: () => _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: _origin.position, zoom: 14.5, tilt: 50.0),
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: kPrimaryColor,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('ORIGIN'),
              ),
            addressFrom != ''
                ? TextButton(
                    onPressed: () {
                      //navigateToAddDeliveryRequestScreen;
                      navigateToAddRideRequestScreen;
                    },
                    style: TextButton.styleFrom(
                      primary: kPrimaryColor,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Icon(Icons.check),
                  )
                : AlertDialog(
                    content: const Text('Your address is empty !!'),
                    actions: [
                      okButton,
                    ],
                  ),
            /*if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: _destination.position, zoom: 14.5, tilt: 50.0),
                ),
              ),
              style: TextButton.styleFrom(
                primary: kPrimaryColor,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DESTINATION'),
            ),*/
          ]),
      body: Stack(alignment: Alignment.center, children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: {
            if (_origin != null) _origin,
            //if (_destination != null) _destination
          },
          polylines: {
            if (info != null)
              Polyline(
                polylineId: const PolylineId('overview_polyline'),
                color: Colors.red,
                width: 5,
                points: info!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
          onLongPress: _addMarker,
        ),
        if (info != null)
          Positioned(
            top: 20.0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: Text('${info!.totalDistance}, ${info!.totalDuration},',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
        onPressed: () => _googleMapController.animateCamera(
          info != null
              ? CameraUpdate.newLatLngBounds(info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  Future<void> _addMarker(LatLng pos) async {
    //if (_origin == null || (_origin != null && _destination != null)) {
    //if (_origin == null && _destination == null) {
    // origin is not set or origin/dest are both Set
    //set origin
    setState(() {
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: pos,
      );
    });
    print(_origin.position);
    print(_origin.position.toString());

    List<Placemark> newPlace = await placemarkFromCoordinates(
        _origin.position.latitude, _origin.position.longitude);
    //Placemark origin = await placemarkFromCoordinates(_origin.position.latitude, _origin.position.longitude);
// this is all you need
    Placemark placeMark = newPlace[0];
    String name = placeMark.name!;
    String subLocality = placeMark.subLocality!;
    String locality = placeMark.locality!;
    String administrativeArea = placeMark.administrativeArea!;
    String postalCode = placeMark.postalCode!;
    String street = placeMark.street!;
    String country = placeMark.country!;
    String addressFrom = '${placeMark.name}'.toString().isNotEmpty
        ? name.toString() +
            " " +
            "${subLocality}".toString() +
            " " +
            "${locality}".toString() +
            " " +
            "${street}".toString() +
            " " +
            "${administrativeArea}".toString() +
            " " +
            "${postalCode}".toString() +
            " " +
            "${country}".toString()
        : '';

    print(addressFrom);

    /*setState(() {
    _address = address; // update _address
  });*/
    /*final directions = await MapDirections().getDirections(
      origin: _origin.position,
      // destination: _destination.position);
      //setState(() => info = directions);
    );*/
  }

  /*Future<void> _addMarkerDestination(LatLng pos) async {
    //if (_origin == null || (_origin != null && _destination != null)) {
    //if (_origin == null && _destination == null) {
    // origin is not set or origin/dest are both Set
    //set origin
    setState(() {
      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: pos,
      );
    });
  }

  Future<void> _addMarker(LatLng pos) async {
    _addMarkerDestination(pos);
    _addMarkerOrigin(pos);
*/
  // Get Directions

  Widget okButton = TextButton(child: const Text("Ok"), onPressed: () {});
}



    /*Future<void> _addMarker(LatLng pos) async {
    //if (_origin == null || (_origin != null && _destination != null)) {
      //if (_origin == null && _destination == null) {
      // origin is not set or origin/dest are both Set
      //set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );

        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });
      // RESET DESTINATION
      // _destination = null!;

      // reset info
      //info = null!;
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
    //} else {
      // origin is already set
      // set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });*/
    //}
/*
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}*/