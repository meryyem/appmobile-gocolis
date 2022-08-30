import 'package:flutter/material.dart';
import 'package:gocolis/constants/colors.dart';
import 'package:gocolis/models/country.dart';

class CountryPage extends StatefulWidget {
  // i will provide the function 'setCountryData' from the loginPage to the country page
  final Function setCountryData;
  const CountryPage({Key? key, required this.setCountryData}) : super(key: key);

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<Country> countries = [
    Country(name: "Tunisia", code: "+216", flag: "🇹🇳"),
    Country(name: "Afghanistan", code: "+004", flag: "AF"),
    Country(name: "ALA	Aland Islands", code: "+248", flag: "AX"),
    Country(name: "Albania", code: "+008", flag: "🇦🇱"),
    Country(name: "Algeria", code: "+012", flag: "DZ"),
    Country(name: "American Samoa", code: "+016", flag: "AS"),
    Country(name: "Andorra", code: "+020", flag: "AD"),
    Country(name: "Angola", code: "+024", flag: "AO"),
    Country(name: "Anguilla", code: "+660", flag: "AI"),
    Country(name: "Antarctica", code: "+010", flag: "AQ"),
    Country(name: "Antigua and Barbuda", code: "+028", flag: "AG"),
    Country(name: "Argentina", code: "+032", flag: "AR"),
    Country(name: "Armenia", code: "+051", flag: "AM"),
    Country(name: "Aruba", code: "+533", flag: "AW"),
    Country(name: "Australia", code: "+036", flag: "AU"),
    Country(name: "Austria", code: "+040", flag: "AT"),
    Country(name: "Azerbaijan", code: "+031", flag: "AZ"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
            ),
          ),
          title: const Text(
            "Choosee a country",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
              wordSpacing: 1,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: countries.length,
          itemBuilder: (context, index) => countryCard(countries[index]),
        ));
  }

  Widget countryCard(Country country) {
    return InkWell(
      onTap: () {
        widget.setCountryData(country);
      },
      child: Card(
        margin: EdgeInsets.all(0.15),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(country.flag),
              const SizedBox(width: 15),
              Text(country.name),
              Expanded(
                child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(country.code),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
