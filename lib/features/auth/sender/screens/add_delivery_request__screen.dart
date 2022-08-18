import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/common/widgets/custom_text_field.dart';
import 'package:gocolis/common/widgets/simple_custom_text.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/constants/global_variables.dart';
import 'package:gocolis/constants/utils.dart';
import 'package:gocolis/features/auth/sender/services/sender_services.dart';
import 'package:gocolis/features/map/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AddDeliveryRequestScreen extends StatefulWidget {
  static const String routeName = '/add-delivery-request';
  const AddDeliveryRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddDeliveryRequestScreen> createState() =>
      _AddDeliveryRequestScreenState();
}

class _AddDeliveryRequestScreenState extends State<AddDeliveryRequestScreen> {
  final TextEditingController deliveryRequestTitleController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressFromController = TextEditingController();
  final TextEditingController addressToController = TextEditingController();
  //final TextEditingController whishedDateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();

  // create an instance from the class
  final SenderServices senderServices = SenderServices();
  List<File> images = [];
  DateTime _dateTime = DateTime.now();
  final _addDeliveryRequestFormKey = GlobalKey<FormState>();
  final String _addressFrom = '';

  @override
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

  void AddDeliveryRequest() {
    if (_addDeliveryRequestFormKey.currentState!.validate() &&
        images.isNotEmpty) {
      senderServices.addDeliveryRequest(
        context: context,
        title: deliveryRequestTitleController.text,
        description: descriptionController.text,
        addressFrom: addressFromController.text,
        addressTo: addressToController.text,
        //whishedDate: whishedDateController.text,
        whishedDate: _dateTime.toString(),
        price: double.parse(priceController.text),
        size: sizeController.text,
        images: images,
        /*onSuccess: () {
            //setState(() {});
            showSnackBar(context, 'Delivery Request Added Successfully ! ');
            Navigator.pop(context);
            //Navigator.pushNamed(context, PostsScreen.routeName);
          },*/
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void navigateToMapScreen() {
    Navigator.pushNamed(context, MapScreen.routeName, arguments: _addressFrom);
  }

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
            'Add A Delivery Request',
            style: TextStyle(
              color: selectedNavBarColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _addDeliveryRequestFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              images.isNotEmpty
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
                    ),
              const SizedBox(
                height: 15,
              ),
              SimpleCustomTextField(
                controller: deliveryRequestTitleController,
                hintText: 'Title',
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleCustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 7,
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleCustomTextField(
                controller: addressFromController,
                hintText: 'Address From',
              ),
              _addressFrom == ''
                  ? ElevatedButton(
                      onPressed: () {
                        navigateToMapScreen();
                      },
                      child: Text('Pick your origin address'),
                    )
                  : Text(_addressFrom),
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
                        controller: whishedDateController,
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
                    .format(DateTime.parse("2222-12-12"))
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
              SimpleCustomTextField(
                controller: sizeController,
                hintText: 'Size',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                boxColor: unselectedNavBarColor,
                onPressed: AddDeliveryRequest,
                text: 'Publish Your Delivery Request',
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
