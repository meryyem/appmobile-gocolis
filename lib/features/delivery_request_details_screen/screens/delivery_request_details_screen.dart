import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/features/auth/sender/screens/add_delivery_request__screen.dart';
import 'package:gocolis/features/auth/sender/services/sender_services.dart';
import 'package:gocolis/models/delivery_request_model.dart';

import '../../../constants/colors.dart';

class DeliveryRequestDetailsScreen extends StatefulWidget {
  static const String routeName = '/delivery-request-details';
  final DeliveryRequest deliveryRequest;
  const DeliveryRequestDetailsScreen({Key? key, required this.deliveryRequest}) : super(key: key);

  @override
  State<DeliveryRequestDetailsScreen> createState() => _DeliveryRequestDetailsScreenState();
}

class _DeliveryRequestDetailsScreenState extends State<DeliveryRequestDetailsScreen> {
  final SenderServices senderServices = SenderServices();
  List<DeliveryRequest>? deliveriesList;
  
  void DeleteDeliveryRequest(DeliveryRequest deliveryRequest, int index) {
    senderServices.deleteDeliveryRequest(
        context: context,
        deliveryRequest: deliveryRequest,
        onSuccess: () {
          deliveriesList!.removeAt(index);
          setState(() {});
        });
  }

  void navigateToAddDeliveryRequest() {
    Navigator.pushNamed(context, AddDeliveryRequestScreen.routeName);
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
                child: Text('GoColis')
              ),
              const Text(
                'Sender', 
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
              child: Text(widget.deliveryRequest.title, style: const TextStyle(fontSize:  15),),
            ),
            CarouselSlider(
              items: widget.deliveryRequest.images.map(
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
            ),
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
                      text: '\$${widget.deliveryRequest.price}',
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
                widget.deliveryRequest.description,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.deliveryRequest.addressFrom,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                widget.deliveryRequest.addressTo,
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
