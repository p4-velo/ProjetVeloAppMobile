import 'package:flutter/material.dart';
import 'package:projet_velo_app_mobile/POO/fav_address_infos.dart';
import 'package:projet_velo_app_mobile/global.dart'as global;
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomButton/view_model.dart';

class MobileView {
  BuildContext context;
  bool isLoading;
  List<FavAddressInfo> favAddressList;
  Function getTexteTest;
  String text;
  

  MobileView({
    required this.context,
    required this.isLoading,
    required this.favAddressList,
    required this.getTexteTest,
    required this.text
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Adresses favorites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: global.primary
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.star_outline,
                    color: Colors.amber,
                    size: 28,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(text),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0 ; i < favAddressList.length ; i++)
                      favAddressTile(favAddressList[i])
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget favAddressTile(FavAddressInfo infos) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    infos.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: global.primary,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: global.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.delete,
                        color: global.deleteColor,
                        size: 28,
                      )
                    ],
                  )
                ],
              ),
              Text(
                infos.address,
                style: TextStyle(
                  color: global.primary,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'AFFICHER SUR LA CARTE',
                callbackFunction: ()  {
                  getTexteTest();
                },
                height: 40,
                width: double.infinity,
                backgroundColor: global.tertiary,
                textColor: Colors.white,
                icon: const Icon(
                  Icons.place,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}