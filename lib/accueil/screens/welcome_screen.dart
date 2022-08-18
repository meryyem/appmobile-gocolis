import 'package:flutter/material.dart';
import 'package:gocolis/common/widgets/custom_button.dart';
import 'package:gocolis/constants/global_variables.dart';

import '../../constants/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Text('GOCOLIS LOGO'),
                //child: Image.asset('assets/images/amazon_in.png', width: 120, height: 45, color: Colors.black,),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15,),
                      child: Icon(Icons.notifications_outlined,),
                    ),
                    Icon(Icons.search,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children : [
          SizedBox(height: size.height * 0.2),
          const Text(
            'role',
            style: TextStyle(

            ),
          ),
          SizedBox(height: size.height * 0.2),
          const Text(
            'role',
            style: TextStyle(

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              CustomButton(
                boxColor: kPrimaryColor,
                color:kPrimaryLightColor,
                text: 'REQUEST A DELIVERY', 
                onPressed: () {},
                //onPressed: () => navigateToLoginScreen(context),
                textColor: kPrimaryColor,
              ),
              SizedBox(width: size.width * 0.1),
              CustomButton(
                boxColor: kPrimaryLightColor,
                text: 'OFFER A DELIVERY', 
                textColor: kPrimaryLightColor,
                onPressed: () {},
                //onPressed: () => navigateToSignUpScreen(context),
                color: kPrimaryColor,
              ),
            ],
          ),
        ],
      )
    );
  }
}