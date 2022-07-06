import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kurdish_names/src/models/name_data_model.dart';

class KurdishNamesService {
  String selectLimit = "5";
  String selectGender = "M";
  String currentSort = "positive";
  List<DropdownMenuItem<String>> limitItems = [
    DropdownMenuItem(child: Text("5"), value: "5"),
    DropdownMenuItem(child: Text("10"), value: "10"),
    DropdownMenuItem(child: Text("15"), value: "15"),
    DropdownMenuItem(child: Text("20"), value: "20"),
    DropdownMenuItem(child: Text("25"), value: "25"),
    DropdownMenuItem(child: Text("30"), value: "30"),
  ];

  List<DropdownMenuItem<String>> genderItems = [
    DropdownMenuItem(child: Text("Female"), value: "F"),
    DropdownMenuItem(child: Text("Male"), value: "M"),
  ];

  List<DropdownMenuItem<String>> sortItems = [
    DropdownMenuItem(child: Text("positive"), value: "positive"),
    DropdownMenuItem(child: Text("negative"), value: "negative"),
  ];

  //function for http request
  Future<KurdishNames> fetchListOfNames() async {
    Uri _kurdishNameUri = Uri(
      scheme: "https",
      host: "nawikurdi.com",
      path: "api",
      queryParameters: {
        "limit": selectLimit,
        "offset": "0",
        "gender": selectGender,
        "sort": currentSort,
      },
    );

    http.Response _response =
        await http.get(_kurdishNameUri).catchError((error) => print(error));
    KurdishNames _kurdishNames = KurdishNames.fromJson(_response.body);

    return _kurdishNames;
  }

//

}
