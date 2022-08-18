import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/features/auth/traveler/screens/add_ride_request.dart';
import 'package:gocolis/features/auth/traveler/services/traveler_services.dart';
import 'package:gocolis/models/ride_request.dart';

class RideRequestDetailsScreen extends StatefulWidget {
  static const String routeName = '/ride-request-details';
  final RideRequest rideRequest;
  const RideRequestDetailsScreen({Key? key, required this.rideRequest}) : super(key: key);

  @override
  State<RideRequestDetailsScreen> createState() => _RideRequestDetailsScreenState();
}

class _RideRequestDetailsScreenState extends State<RideRequestDetailsScreen> {
  final TravelerServices travelerServices = TravelerServices();
  List<RideRequest>? ridesList;
  
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text('GoColis')
              ),
              const Text(
                'Traveler', 
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox( height: 15),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.deliveryRequest.id!),
                ],
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10,),
              child: Text(widget.rideRequest.title, style: const TextStyle(fontSize:  15),),
            ),
            /*CarouselSlider(
              items: widget.rideRequest.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                height: 300,
              ),
            ),*/
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Price:   ',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: '\$${widget.rideRequest.price}',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.rideRequest.addressFrom,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.rideRequest.addressTo,
              ),
            ),
            CustomButton(
                boxColor: unselectedNavBarColor,
                onPressed: () {},
                //onPressed: () => UpdateDeliveryRequest(widget.deliveryRequest),
                text: 'Update',
                textColor: unselectedNavBarColor,
                color: selectedNavBarColor,
              ),
              CustomButton(
                boxColor: unselectedNavBarColor,
                onPressed: () {},
                //onPressed: () => UpdateDeliveryRequest(widget.deliveryRequest),
                text: 'Delete',
                textColor: unselectedNavBarColor,
                color: selectedNavBarColor,
              ),
            
          ]
        ),
        ),
    );
  }
}
