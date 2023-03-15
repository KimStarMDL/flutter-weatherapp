import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apiKey = '4aee07690ec342a98a8cac98c285842a';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double latitude3;
  double longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    // network.dart 파일에서 api url 정보를 받아옴 주소2개가 들어가는 이유는 생성자가 2개이기 때문
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution'
            '?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    // 데이터를 담는 곳
    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherScreen(
        // 변수 정보를 불러와서 전달
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

  // void fetchData() async {

  //     var myJson = parsingData(jsonData)['weather'][0]['description'];
  //     print(myJson);

  //     var wind = parsingData(jsonData)['wind']['speed'];
  //     print(wind);

  //     var id = parsingData(jsonData)['id'];
  //     print(id);
  //   } else {
  //     print(response.statusCode);
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text(
            'Get my location',
            style: TextStyle(color: Colors.white),
          ),
          // color: Colors.blue,
        ),
      ),
    );
  }
}
