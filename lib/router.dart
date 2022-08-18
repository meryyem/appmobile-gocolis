import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/error.dart';
import 'package:gocolis/features/auth/sender/screens/add_delivery_request__screen.dart';
import 'package:gocolis/features/auth/authSignUp/screens/otp_screen.dart';
import 'package:gocolis/features/auth/sender/screens/facebook_login_page.dart';
import 'package:gocolis/features/auth/sender/screens/google_login.dart';
import 'package:gocolis/features/auth/sender/screens/sender_home.dart';
import 'package:gocolis/features/auth/sender/screens/sender_login_screen.dart';
import 'package:gocolis/features/auth/traveler/screens/add_ride_request.dart';
import 'package:gocolis/features/auth/traveler/screens/ride_details_screen.dart';
import 'package:gocolis/features/auth/traveler/screens/traveler_home.dart';
import 'package:gocolis/features/auth/traveler/screens/traverler_login_screen.dart';
import 'package:gocolis/features/auth/traveler/screens/update_ride_request.dart';
import 'package:gocolis/features/home/screens/home_screen.dart';
import 'package:gocolis/features/map/screens/map_screen.dart';
import 'package:gocolis/models/delivery_request_model.dart';
import 'package:gocolis/models/ride_request.dart';

import 'features/auth/sender/screens/update_delivery_details_screen.dart';
import 'features/delivery_request_details_screen/screens/delivery_request_details_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SenderLoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SenderLoginScreen(),
      );

    case TravelerLoginScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const TravelerLoginScreen(),
      );

    case OTPScreen.routeName:
      var firstName = routeSettings.arguments as String;
      var lastName = routeSettings.arguments as String;
      var email = routeSettings.arguments as String;
      var password = routeSettings.arguments as String;
      var birthDate = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OTPScreen(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          birthDate: birthDate,
        ),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
    /*case FacebookLogin.routeName:
      return MaterialPageRoute(
        builder: (context) => const FacebookLogin(),
      );
    case GoogleLogin.routeName:
      return MaterialPageRoute(
        builder: (context) => const GoogleLogin(),
      );*/
    case SenderHome.routeName:
      return MaterialPageRoute(
        builder: (_) => const SenderHome(),
      );
    case AddDeliveryRequestScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddDeliveryRequestScreen(),
      );
    case DeliveryRequestDetailsScreen.routeName:
      var deliveryRequest = routeSettings.arguments as DeliveryRequest;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DeliveryRequestDetailsScreen(
          deliveryRequest: deliveryRequest,
        ),
      );
    case UpdateDeliveryRequestScreen.routeName:
      DeliveryRequest deliveryRequest = routeSettings.arguments as DeliveryRequest;
      /*var title =  routeSettings.arguments as String;
      var description = routeSettings.arguments as String;
      var addressFrom = routeSettings.arguments as String;
      var addressTo = routeSettings.arguments as String;
      var whishedDate = routeSettings.arguments as String;
      var price = routeSettings.arguments as double;
      var size =  routeSettings.arguments as String;
      var images= routeSettings.arguments as String;*/
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UpdateDeliveryRequestScreen(
          deliveryRequest : deliveryRequest,
          /*title: title,
          description: description,
          addressFrom: addressFrom,
          addressTo: addressTo,
          whishedDate: whishedDate,
          price: price,
          size: size,
          images: images,*/
        ),
      );
      case TravelerHome.routeName:
      return MaterialPageRoute(
        builder: (_) => const TravelerHome(),
      );
    case AddRide.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddRide(),
      );
    case RideRequestDetailsScreen.routeName:
      var rideRequest = routeSettings.arguments as RideRequest;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => RideRequestDetailsScreen(
          rideRequest: rideRequest,
        ),
      );
    case UpdateRideRequestScreen.routeName:
      RideRequest rideRequest = routeSettings.arguments as RideRequest;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => UpdateRideRequestScreen(
          rideRequest : rideRequest,
        ),
      );
      case MapScreen.routeName:
      var addressFrom = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => MapScreen(
          addressFrom: addressFrom,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}
