import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/common/widgets/simple_custom_text.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/features/auth/traveler/services/traveler_services.dart';
import 'package:gocolis/models/ride_request.dart';
import 'package:intl/intl.dart';

class UpdateRideRequestScreen extends StatefulWidget {
  static const String routeName = '/update-ride-request';
  final RideRequest rideRequest;
  const UpdateRideRequestScreen({
    Key? key,
    required this.rideRequest,
  }) : super(key: key);

  @override
  State<UpdateRideRequestScreen> createState() =>
      _UpdateRideRequestScreenState();
}

class _UpdateRideRequestScreenState extends State<UpdateRideRequestScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressFromController = TextEditingController();
  final TextEditingController addressToController = TextEditingController();
  //final TextEditingController whishedDateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // create an instance from the class
  final TravelerServices travelerServices = TravelerServices();
  //List<File> images = [];
  DateTime _dateTime = DateTime.now();
  final _updateRideRequestFormKey = GlobalKey<FormState>();
  String whishedDate = DateTime.now().toString();

/*  @override
  void dispose() {
    super.dispose();
    deliveryRequestTitleController.dispose();
    descriptionController.dispose();
    addressFromController.dispose();
    addressToController.dispose();
    //whishedDateController.dispose();
    priceController.dispose();
    sizeController.dispose();
  }
*/

  @override
  void initState() {
    titleController.text = widget.rideRequest.title;
    addressFromController.text = widget.rideRequest.addressFrom;
    addressToController.text = widget.rideRequest.addressTo;
    whishedDate = _dateTime.toString();
    //_dateTime = _dateTime.toString();
    priceController.text = widget.rideRequest.price.toString();
    //images = images;
    super.initState();
  }

  void UpdateRideRequest(RideRequest rideRequest) {
    if (_updateRideRequestFormKey.currentState!.validate()
        //&& images.isNotEmpty
        ) {
      travelerServices.updateRideRequest(
        context: context,
        rideRequest: rideRequest,
        title: titleController.text,
        addressFrom: addressFromController.text,
        addressTo: addressToController.text,
        //whishedDate: whishedDateController.text,
        whishedDate: _dateTime.toString(),
        price: double.parse(priceController.text),
        //images: images,
        onSuccess: () {
          showSnackBar(context, 'Ride Request Modified Successfully ! ');
          Navigator.pop(context);
        },
      );
    }
  }

  /*void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Update Your Ride Request',
            style: TextStyle(
              color: selectedNavBarColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _updateRideRequestFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              /*images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        height: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Select Your Delivery Images',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
              const SizedBox(
                height: 15,
              ),
              SimpleCustomTextField(
                controller: titleController,
                hintText: widget.rideRequest.title,
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleCustomTextField(
                controller: addressFromController,
                hintText: 'Address From',
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleCustomTextField(
                controller: addressToController,
                hintText: 'Address To',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*Text(_dateTime == null
                        ? 'Nothing has been picked yet'
                        : _dateTime.toString()),*/
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate:
                            _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      ).then((date) {
                        setState(() {
                          _dateTime = date!;
                        });
                      });
                    },
                    child: Text(_dateTime == null
                        ? 'Nothing has been picked yet'
                        : DateFormat('dd/MM/yyyy')
                            .format(_dateTime)
                            .toString()),
                    /*child: Text('Whished Date'),
                    style: ElevatedButton.styleFrom(
                      primary: unselectedNavBarColor,
                      minimumSize: Size(size.width * 0.15, size.height * 0.05),
                    ),*/
                  ),
                  /*Container(
                    width: size.width * 0.65,
                    child: TextFormField(
                        controller: whishedDate,
                        onChanged: (val) {
                          val = _dateTime.toString();
                        }),
                  ),*/
                ],
              ),
              /*CustomTextField(
                    onChanged: (String value) { 
                      value = _dateTime.toString();
                    }, 
                    obscureText: false, icon: null, iconColor: null, hintText: '',
                    
                  )*/
              SizedBox(
                  child: Text(
                DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(whishedDate))
                    .toString(),
              )),
              const SizedBox(
                height: 10,
              ),
              SimpleCustomTextField(
                controller: priceController,
                hintText: 'Price',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                boxColor: unselectedNavBarColor,
                onPressed: () => UpdateRideRequest(widget.rideRequest),
                text: 'Save',
                textColor: unselectedNavBarColor,
                color: selectedNavBarColor,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
