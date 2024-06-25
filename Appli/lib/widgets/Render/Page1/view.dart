import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MobileView {
  BuildContext context;
  bool isLoading;

  MobileView({
    required this.context,
    required this.isLoading,
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Text('ça va ? '),
          ),
          body: isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Column(
            children: [
              const Text('Page1'),
              Expanded(
                child: OpenStreetMapSearchAndPick(
                  buttonTextStyle: const TextStyle(
                      fontSize: 18, fontStyle: FontStyle.normal),
                  buttonColor: Colors.blue,
                  buttonText: 'Set Current Location',
                  onPicked: (pickedData) {
                    print(pickedData.latLong.latitude);
                    print(pickedData.latLong.longitude);
                    print(pickedData.address);
                    print(pickedData.addressName);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
