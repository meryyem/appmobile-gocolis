import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/decorated_container.dart';
import 'package:gocolis/common/widgets/loader.dart';
import 'package:gocolis/features/auth/traveler/screens/add_ride_request.dart';
import 'package:gocolis/features/auth/traveler/screens/ride_details_screen.dart';
import 'package:gocolis/features/auth/traveler/screens/update_ride_request.dart';
import 'package:gocolis/features/auth/traveler/services/traveler_services.dart';
import 'package:gocolis/models/ride_request.dart';

class RideRequestScreen extends StatefulWidget {
  //static const String routeName = '/posts-screen';
  const RideRequestScreen({Key? key}) : super(key: key);

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  List<RideRequest>? ridesList;
  final TravelerServices travelerServices = TravelerServices();

  @override
  void initState() {
    super.initState();
    FetchAllRides();
  }

  FetchAllRides() async {
    ridesList = await travelerServices.fetchAllRides(context);
    setState(() {});
  }

  void DeleteRideRequest(RideRequest rideRequest, int index) {
    travelerServices.deleteRideRequest(
        context: context,
        rideRequest: rideRequest,
        onSuccess: () {
          ridesList!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddRideRequest() {
    Navigator.pushNamed(context, AddRide.routeName);
  }

  void navigateToUpdateRideRequest(RideRequest rideRequest, int index) {
    Navigator.pushNamed(context, UpdateRideRequestScreen.routeName, arguments: rideRequest);
  }

  @override
  Widget build(BuildContext context) {
    return ridesList == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: ridesList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (context, index) {
                final ridesData = ridesList![index];
                return Container(
                  height: 125,
                  child: DecoratedItem(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /*SizedBox(
                              height: 120,
                              child: SingleItem(
                                image: ridesData.images[0],
                              ),
                            ),*/
                            Expanded(
                              child: Text(
                                ridesData.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      navigateToUpdateRideRequest(ridesData, index),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () =>
                                    DeleteRideRequest(ridesData, index),
                                  icon: const Icon(Icons.delete_outline),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RideRequestDetailsScreen.routeName,
                                        arguments: ridesData);
                                  }, 
                                  child: Text('See details'),
                                  /*style: ButtonStyle(
                                    backgroundColor: ,
                                  ),*/
                                ),
                              ],
                            ), 
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddRideRequest,
              tooltip: 'Add Your Ride Request',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
