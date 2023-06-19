import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../component/weatheritem.dart';
import '../methods/Constants.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, this.dailyForecastWeather}) : super(key: key);
  final dailyForecastWeather;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Constants myconstants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecastWeather;

    Map getForecastWeather(int index) {
      int maxWindSpeed = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avgHumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceOfRain =
          weatherData[index]["day"]["daily_chance_of_rain"].toInt();

      var parsedDate = DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: myconstants.primaryColor,
      appBar: AppBar(
        backgroundColor: myconstants.primaryColor,
        title: Text('Forecasts'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                print('Setting Taped');
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.settings),
              ))
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 320,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0Xffa9c1f5),
                                Color(0Xff6696f5),
                              ]),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blue.withOpacity(.1),
                                offset: Offset(0, 25),
                                blurRadius: 3,
                                spreadRadius: -10)
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset('assets/' +
                                getForecastWeather(0)['weatherIcon']),
                            width: 150,
                          ),
                          Positioned(
                              top: 150,
                              left: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  getForecastWeather(0)['weatherName'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                          Positioned(
                              bottom: 20,
                              left: 20,
                              child: Container(
                                width: size.width * .8,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      weatheritem(
                                        value: getForecastWeather(
                                            0)['maxWindSpeed'],
                                        unit: 'km/h',
                                        imageurl: 'assets/windspeed.png',
                                      ),
                                      weatheritem(
                                        value: getForecastWeather(
                                            0)['avgHumidity'],
                                        unit: '%',
                                        imageurl: 'assets/humidity.png',
                                      ),
                                      weatheritem(
                                        value: getForecastWeather(
                                            0)['chanceOfRain'],
                                        unit: '%',
                                        imageurl: 'assets/windspeed.png',
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          Positioned(
                              top: 20,
                              right: 20,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getForecastWeather(0)['maxTemperature']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 80,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = myconstants.shader),
                                  ),
                                  Text(
                                    'o',
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                        foreground: Paint()
                                          ..shader = myconstants.shader),
                                  ),
                                ],
                              )),
                          Positioned(
                              top: 325,
                              left: 0,
                              child: SizedBox(
                                height: 400,
                                width: size.width * .9,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    Card(
                                      elevation: 3.0,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getForecastWeather(
                                                      0)['forecastDate'],
                                                  style: TextStyle(
                                                      color: Color(0xff6696f5),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(0)[
                                                                  'minTemperature']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .greyColor,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .greyColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        "sups"),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(0)[
                                                                  'maxTemperature']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .blackColor,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .blackColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        "sups"),
                                                              ]),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/' +
                                                          getForecastWeather(
                                                              0)["weatherIcon"],
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      getForecastWeather(
                                                          0)['weatherName'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getForecastWeather(0)[
                                                                  'chanceOfRain']
                                                              .toString() +
                                                          '%',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image.asset(
                                                      'assets/lightrain.png',
                                                      width: 30,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 3.0,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getForecastWeather(
                                                      1)['forecastDate'],
                                                  style: TextStyle(
                                                      color: Color(0xff6696f5),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(1)[
                                                                  'minTemperature']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .greyColor,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .greyColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        "sups"),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(1)[
                                                                  'maxTemperature']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .blackColor,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .blackColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        "sups"),
                                                              ]),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/' +
                                                          getForecastWeather(
                                                              1)["weatherIcon"],
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      getForecastWeather(
                                                          0)['weatherName'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getForecastWeather(1)[
                                                                  'chanceOfRain']
                                                              .toString() +
                                                          '%',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image.asset(
                                                      'assets/lightrain.png',
                                                      width: 30,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 3.0,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  getForecastWeather(
                                                      2)['forecastDate'],
                                                  style: TextStyle(
                                                      color: Color(0xff6696f5),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(2)[
                                                                  'minTemperature']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .greyColor,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .greyColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        "sups"),
                                                              ]),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          getForecastWeather(2)[
                                                                  'maxTemperature']
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .blackColor,
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          'o',
                                                          style: TextStyle(
                                                              color: myconstants
                                                                  .blackColor,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFeatures: [
                                                                FontFeature
                                                                    .enable(
                                                                        "sups"),
                                                              ]),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/' +
                                                          getForecastWeather(
                                                              2)["weatherIcon"],
                                                      width: 30,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      getForecastWeather(
                                                          2)['weatherName'],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      getForecastWeather(0)[
                                                                  'chanceOfRain']
                                                              .toString() +
                                                          '%',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image.asset(
                                                      'assets/lightrain.png',
                                                      width: 30,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
