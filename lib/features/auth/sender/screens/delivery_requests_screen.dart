import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/decorated_container.dart';
import 'package:gocolis/common/widgets/loader.dart';
import 'package:gocolis/features/account/widgets/single_item.dart';
import 'package:gocolis/features/auth/sender/screens/add_delivery_request__screen.dart';
import 'package:gocolis/features/auth/sender/screens/update_delivery_details_screen.dart';
import 'package:gocolis/features/auth/sender/services/sender_services.dart';
import 'package:gocolis/models/delivery_request_model.dart';
import '../../../delivery_request_details_screen/screens/delivery_request_details_screen.dart';

class DeliveryRequestsScreen extends StatefulWidget {
  //static const String routeName = '/posts-screen';
  const DeliveryRequestsScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryRequestsScreen> createState() => _DeliveryRequestsScreenState();
}

class _DeliveryRequestsScreenState extends State<DeliveryRequestsScreen> {
  List<DeliveryRequest>? deliveriesList;
  final SenderServices senderServices = SenderServices();

  @override
  void initState() {
    super.initState();
    FetchAllDeliveries();
  }

  FetchAllDeliveries() async {
    deliveriesList = await senderServices.fetchAllDeliveries(context);
    setState(() {});
  }

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

  void navigateToUpdateDeliveryRequest(DeliveryRequest deliveryRequest, int index) {
    Navigator.pushNamed(context, UpdateDeliveryRequestScreen.routeName, arguments: deliveryRequest);
  }

  @override
  Widget build(BuildContext context) {
    return deliveriesList == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: deliveriesList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1),
              itemBuilder: (context, index) {
                final deliveriesData = deliveriesList![index];
                return Container(
                  height: 125,
                  child: DecoratedItem(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 120,
                              child: SingleItem(
                                image: deliveriesData.images[0],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                deliveriesData.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Column(
                              children: [
                                
                                IconButton(
                                  onPressed: () =>
                                      navigateToUpdateDeliveryRequest(deliveriesData, index),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      DeleteDeliveryRequest(deliveriesData, index),
                                  icon: const Icon(Icons.delete_outline),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, DeliveryRequestDetailsScreen.routeName,
                                        arguments: deliveriesData);
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
              onPressed: navigateToAddDeliveryRequest,
              tooltip: 'Add Your Delivery Request',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
