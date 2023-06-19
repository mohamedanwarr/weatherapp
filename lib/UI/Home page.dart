import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherapp/methods/Constants.dart';

import '../component/weatheritem.dart';
import 'Details Screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _CityController = TextEditingController();
  Constants myconstants = Constants();
  static String API_KEY = 'dda52ad52ae6440b8bf201440231004';

  String location = 'Cairo'; //Default location
  String weatherIcon = 'heavycloudy.png';
  int temperature = 0;
  int windSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = '';

  List hourlyWeatherForecast = [];
  List dailyWeatherForecast = [];

  String currentWeatherStatus = '';

  //API CALL
  String searchWeatherAPI = 'https://api.weatherapi.com/v1/forecast.json?key=' +
      API_KEY +
      "&days=7&q=";

  void fetchWeatherData(String searchText) async {
    try {
      var searchResult =
          await http.get(Uri.parse(searchWeatherAPI + searchText));

      final weatherData = Map<String, dynamic>.from(
          json.decode(searchResult.body) ?? 'No data');

      var locationData = weatherData["location"];

      var currentWeather = weatherData["current"];

      setState(() {
        location = getShortLocationName(locationData["name"]);

        var parsedDate =
            DateTime.parse(locationData["localtime"].substring(0, 10));
        var newDate = DateFormat('MMMMEEEEd').format(parsedDate);
        currentDate = newDate;

        //updateWeather
        currentWeatherStatus = currentWeather["condition"]["text"];
        weatherIcon =
            "${currentWeatherStatus.replaceAll(' ', '').toLowerCase()}.png";
        temperature = currentWeather["temp_c"].toInt();
        windSpeed = currentWeather["wind_kph"].toInt();
        humidity = currentWeather["humidity"].toInt();
        cloud = currentWeather["cloud"].toInt();

        //Forecast data
        dailyWeatherForecast = weatherData["forecast"]["forecastday"];
        hourlyWeatherForecast = dailyWeatherForecast[0]["hour"];
      });
    } catch (e) {
      //debugPrint(e);
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(" ");

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return "${wordList[0]} ${wordList[1]}";
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  @override
  void initState() {
    fetchWeatherData(location);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
            color: myconstants.primaryColor.withOpacity(.1),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: size.height * .7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: myconstants.linearGradientBlue,
                      boxShadow: [
                        BoxShadow(
                            color: myconstants.primaryColor.withOpacity(.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/menu.png',
                              width: 40,
                              height: 40,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/pin.png',
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  location,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.8),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _CityController.clear();
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Container(
                                                  height: size.height * .2,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SizedBox(
                                                        width: 70,
                                                        child: Divider(
                                                          thickness: 3.5,
                                                          color: myconstants
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      TextField(
                                                        onChanged:
                                                            (searchtext) {
                                                          fetchWeatherData(
                                                              searchtext);
                                                        },
                                                        controller:
                                                            _CityController,
                                                        autofocus: false,
                                                        decoration:
                                                            InputDecoration(
                                                                prefixIcon:
                                                                    Icon(
                                                                  Icons.search,
                                                                  color: myconstants
                                                                      .primaryColor,
                                                                ),
                                                                suffixIcon:
                                                                    GestureDetector(
                                                                  onTap: () =>
                                                                      _CityController
                                                                          .clear(),
                                                                  child: Icon(
                                                                    Icons.close,
                                                                    color: myconstants
                                                                        .primaryColor,
                                                                  ),
                                                                ),
                                                                hintText:
                                                                    'Search city e.g. London',
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              myconstants.primaryColor,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.white))
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/checked.png',
                                width: 40,
                                height: 40,
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: SizedBox(
                            height: 160,
                            child: Image.asset('assets/$weatherIcon'),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                temperature.toString(),
                                style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = myconstants.shader),
                              ),
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
                        ),
                        Column(
                          children: [
                            Center(
                              child: Text(
                                currentWeatherStatus,
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 20.0),
                              ),
                            ),
                            Text(
                              currentDate,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(
                            color: Colors.white70,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                weatheritem(
                                  value: windSpeed.toInt(),
                                  unit: 'km/h',
                                  imageurl: 'assets/windspeed.png',
                                ),
                                weatheritem(
                                  value: humidity.toInt(),
                                  unit: '%',
                                  imageurl: 'assets/humidity.png',
                                ),
                                weatheritem(
                                  value: cloud.toInt(),
                                  unit: 'km/h',
                                  imageurl: 'assets/cloud.png',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: size.height * .20,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Today',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(dailyForecastWeather: dailyWeatherForecast,)));
                                  },
                                  child: Text(
                                    "Forecasts",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: myconstants.primaryColor),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                                height: 110,
                                child: ListView.builder(
                                    itemCount: hourlyWeatherForecast.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String currentTime =
                                          DateFormat('HH:mm:ss')
                                              .format(DateTime.now());
                                      String currentHour =
                                          currentTime.substring(0, 2);

                                      String forecastTime =
                                          hourlyWeatherForecast[index]["time"]
                                              .substring(11, 16);
                                      String forecastHour =
                                          hourlyWeatherForecast[index]["time"]
                                              .substring(11, 13);

                                      String forecastWeatherName =
                                          hourlyWeatherForecast[index]
                                              ["condition"]["text"];
                                      String forecastWeatherIcon =
                                          "${forecastWeatherName
                                                  .replaceAll(' ', '')
                                                  .toLowerCase()}.png";

                                      String forecastTemperature =
                                          hourlyWeatherForecast[index]["temp_c"]
                                              .round()
                                              .toString();
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        width: 65,
                                        decoration: BoxDecoration(
                                            color: currentHour == forecastHour
                                                ? Colors.white
                                                : myconstants.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50)),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 1),
                                                blurRadius: 5,
                                                color: myconstants.primaryColor
                                                    .withOpacity(.2),
                                              ),
                                            ]),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              forecastTime,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: myconstants.greyColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/$forecastWeatherIcon',
                                              width: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  forecastTemperature,
                                                  style: TextStyle(
                                                    color:
                                                        myconstants.greyColor,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text('°',
                                                    style: TextStyle(
                                                        color: myconstants
                                                            .greyColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 17,
                                                        fontFeatures: const [
                                                          FontFeature.enable(
                                                              'sups'),
                                                          // Set the number of items to display
                                                        ]))
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }))
                          ]))
                ])));
  }
}
