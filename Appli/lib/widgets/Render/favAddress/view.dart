import 'package:flutter/material.dart';
import 'package:projet_velo_app_mobile/global.dart'as global;
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomButton/view_model.dart';

import '../../../POO/FavoritePlace.dart';

class MobileView {
  BuildContext context;
  bool isLoading;
  List<FavoritePlace> favAddressList;


  MobileView({
    required this.context,
    required this.isLoading,
    required this.favAddressList,
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

  Widget favAddressTile(FavoritePlace infos) {
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