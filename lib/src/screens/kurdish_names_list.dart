import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kurdish_names/src/models/name_data_model.dart';
import 'package:kurdish_names/src/services/kurdish_names_service.dart';

class KurdishNamesList extends StatefulWidget {
  KurdishNamesList({Key? key}) : super(key: key);

  @override
  State<KurdishNamesList> createState() => _KurdishNamesListState();
}

class _KurdishNamesListState extends State<KurdishNamesList> {
  KurdishNamesService _kurdishNamesService = KurdishNamesService();
  bool isPositive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // filterWidget("title", _kurdishNamesService.selectLimit,
                  //     _kurdishNamesService.limitItems),
                  Column(
                    children: [
                      const Text(
                        "limit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                        value: _kurdishNamesService.selectLimit,
                        items: _kurdishNamesService.limitItems,
                        onChanged: (String? val) {
                          setState(() {
                            _kurdishNamesService.selectLimit = val!;
                            // print(currentSelected);
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                        value: _kurdishNamesService.selectGender,
                        items: _kurdishNamesService.genderItems,
                        onChanged: (String? val) {
                          setState(() {
                            _kurdishNamesService.selectGender = val!;
                            // print(currentSelected);
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Sort By",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton(
                        elevation: 0,
                        value: _kurdishNamesService.currentSort,
                        items: _kurdishNamesService.sortItems,
                        onChanged: (String? val) {
                          setState(() {
                            _kurdishNamesService.currentSort = val!;
                            isPositive = !isPositive;
                            // print(currentSelected);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: FutureBuilder<KurdishNames>(
                  future: _kurdishNamesService.fetchListOfNames(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.data == null) {
                      return const Text("No Data");
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.names.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ExpansionTile(
                              title: Text(
                                snapshot.data!.names[index].name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              leading: isPositive
                                  ? Text(snapshot
                                      .data!.names[index].positive_votes
                                      .toString())
                                  : Text(snapshot
                                      .data!.names[index].negative_votes
                                      .toString()),
                              children: [
                                Text(
                                  snapshot.data!.names[index].desc,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget filterWidget(
      String title, String value, List<DropdownMenuItem<String>> menuItems) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton(
          value: value,
          items: menuItems,
          onChanged: (String? val) {
            setState(() {
              _kurdishNamesService.selectLimit = val!;

              //  print(value);
            });
          },
        ),
      ],
    );
  }
}
