import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomButton/view_model.dart';

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
          backgroundColor: global.secondary,
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/logo_dijon_metropole.png',
                      width: 200,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Dij\'on Bike',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height:  20),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Connexion",
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              cursorColor: global.secondary,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: GoogleFonts.ptSans(
                                  textStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                                ),
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  size: 22,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: global.tertiary,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            child: TextFormField(
                              cursorColor: global.secondary,
                              decoration: InputDecoration(
                                hintText: "Mot de passe",
                                hintStyle: GoogleFonts.ptSans(
                                  textStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  size: 22,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: global.tertiary,
                                    width: 2,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(
                            callbackFunction: () {
                              context.go('/map');
                            },
                            text: 'SE CONNECTER',
                            backgroundColor: global.tertiary,
                            textColor: Colors.white,
                            height: 50,
                            width: constraints.maxWidth
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "OU",
                                style: GoogleFonts.montserrat(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomButton(
                            callbackFunction: () {
                              context.go('/signup');
                            },
                            text: 'CREER UN COMPTE',
                            textColor: global.tertiary,
                            height: 50,
                            width: constraints.maxWidth
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}