import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the UI
  String time; //time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoint
  bool isDaytime; //true  or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make the request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      String min_offset = data['utc_offset'].substring(4);
      //print(datetime);
      //print(offset);

      //create a DateTime object

      // DateTime now = DateTime.parse(datetime);
      // now = now.add(Duration(hours: int.parse(offset)));
      // DateTime now = new DateTime.now();
      // DateTime date = new DateTime(now.year, now.month, now.day);
      var now = DateTime.parse(datetime); // 8:18pm
      now = now.add(
          Duration(hours: int.parse(offset), minutes: int.parse(min_offset)));
      print(now);

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'could not get time data';
    }
  }
}
