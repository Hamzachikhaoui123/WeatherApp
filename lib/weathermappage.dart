import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class WeatherMap extends StatefulWidget {
  @override
  _WeatherMapState createState() => _WeatherMapState();
}

class _WeatherMapState extends State<WeatherMap> {
  var searchController = TextEditingController();
  String titre = "";
  String name = "";
  String imagePath = "assets/sun.png";
  String imageBg = "assets/silhouette-bicycle-parking-mountain.jpg";
  var temp = 0.0;
  var id = 0;
  var rag = 0;
  void CallApi() async {
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=${searchController.text}&APPID=06e864f389e3d0bd93a3183b1612d368');
    var response = await http.get(url);
    var myBody = jsonDecode(response.body);

    setState(() {
      titre = myBody['weather'][0]['main'];
      name = myBody['name'];
      temp = myBody['main']['temp'] - 273.15;
      id = myBody['weather'][0]['id'];
      rag = myBody['wind']['deg'];
      print(id);
      if (id >= 200 && id <= 232) {
        imagePath = 'assets/thunderstorm.png';
        imageBg = "assets/thunderstorm.jpg";
      } else if (id >= 300 && id <= 321) {
        imagePath = 'assets/drizzle.png';
      } else if (id >= 500 && id <= 531) {
        imagePath = 'assets/rainy.png';
      } else if (id >= 600 && id <= 622) {
        imagePath = 'assets/snowflake.png';
      } else if (id >= 701 && id <= 781) {
        imagePath = 'assets/atmosphere.png';
      } else {
        imagePath = 'assets/sun.png';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageBg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                elevation: 0, primary: Colors.transparent),
                            onPressed: () {
                              CallApi();
                            },
                            icon: Icon(Icons.search_rounded),
                            label: Text('')),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(50),
                            height: 43,
                            child: TextFormField(
                              controller: searchController,
                              obscureText: false,
                              style: TextStyle(fontSize: 22),
                              cursorColor: Colors.deepOrange,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0.0)),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: 'City',
                                labelStyle: TextStyle(color: Colors.deepOrange),
                                prefixIcon: GestureDetector(
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: Colors.black,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            width: 40,
                            height: 35,
                            child: Image.asset(
                              'assets/loc.png',
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 40, 0),
                            child: Text(
                              name,
                              style:
                                  TextStyle(fontSize: 38, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    //Affiche(),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Text(
                          titre,
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: .5,
                                fontSize: 25,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Center(
                      child: Text(
                        '${temp.toStringAsFixed(1)}°C',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                    /* Text(
                      temper,
                    )*/
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          child: Image.asset('assets/windy_weather1600.png'),
                        ),
                        Container(
                          child: Center(
                            child: Text(
                              '${rag}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 90,
                        height: 90,
                        child: Image.asset(imagePath),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
