import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomButton/view_model.dart';
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomTextField/view_model.dart';
import '../../../ApiService.dart';
import '../../../POO/FavoritePlace.dart';

class MobileView {
  BuildContext context;
  bool isLoading;
  List<FavoritePlace> favAddressList;
  ApiService apiService = ApiService(); // Instance de votre ApiService
  // bool openAddFavWindow;
  // Function openAddFavWindowCall;
  TextEditingController controllerName;
  TextEditingController controllerAddress;
  bool isErrorName;
  bool isErrorAddress;
  String errorTypeName;
  String errorTypeAddress;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.favAddressList,
    // required this.openAddFavWindow,
    // required this.openAddFavWindowCall,
    required this.controllerName,
    required this.controllerAddress,
    required this.isErrorName,
    required this.isErrorAddress,
    required this.errorTypeName,
    required this.errorTypeAddress
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 70), // Bottom padding increased to accommodate the FAB
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Adresses favorites',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: global.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star_outline,
                        color: Colors.amber,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: favAddressList.length,
                      itemBuilder: (context, index) {
                        return favAddressTile(favAddressList[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: buildButtonAdd(context),
            ),
          ],
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: global.primary,
                          size: 28,
                        ),
                        onPressed: () {
                          // Ajoutez ici la logique pour l'édition
                        },
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await apiService.deleteFavoritePlace(infos.id);
                            context.go('/fav_address');
                            print('Lieu favori avec l\'ID ${infos.id} supprimé avec succès');
                          } catch (e) {
                            print('Erreur lors de la suppression du lieu favori: $e');
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: global.deleteColor,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                infos.address,
                style: TextStyle(
                  color: global.primary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'AFFICHER SUR LA CARTE',
                callbackFunction: () {
                  print(infos.latitude);
                  print(infos.longitude);
                  context.go('/map?latitude=${infos.latitude}&longitude=${infos.longitude}');
                },
                height: 40,
                width: double.infinity,
                backgroundColor: global.tertiary,
                textColor: Colors.white,
                icon: const Icon(
                  Icons.place,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildButtonAdd(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {
          // Ajoutez ici la logique pour ajouter une nouvelle adresse favorite
          // addFavWindow(context);
        },
        child: Icon(
          Icons.add,
          color: global.primary,
          size: 35,
        ),
      ),
    );
  }

  // void addFavWindow(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         insetPadding: const EdgeInsets.all(20),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Modifier l'adresse favorite",
  //               style: TextStyle(
  //                 color: global.secondary,
  //                 fontWeight: FontWeight.bold
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //             Expanded(
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     CustomTextField(
  //                       controller: controllerName,
  //                       hintText: "Nom",
  //                       isError: isErrorName,
  //                       errorType: errorTypeName
  //                     ),
  //                     const SizedBox(height: 10),
  //                     CustomTextField(
  //                       controller: controllerAddress,
  //                       hintText: "Adresse",
  //                       isError: isErrorAddress,
  //                       errorType: errorTypeAddress
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 CustomButton(
  //                   text: "Retour",
  //                   callbackFunction: () {},
  //                   height: 40,
  //                   width: 110
  //                 ),
  //                 CustomButton(
  //                   text: "Modifier",
  //                   backgroundColor: global.secondary,
  //                   textColor: Colors.white,
  //                   callbackFunction: () {},
  //                   height: 40,
  //                   width: 110
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
