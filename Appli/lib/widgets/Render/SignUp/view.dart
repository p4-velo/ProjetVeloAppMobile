import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomButton/view_model.dart';
import 'package:projet_velo_app_mobile/widgets/CustomWidget/CustomTextField/view_model.dart';

class MobileView {
  BuildContext context;
  bool isLoading;
  dynamic formKey;
  Function validateSignUp;
  TextEditingController controllerUsername;
  TextEditingController controllerEmail;
  TextEditingController controllerPassword;
  TextEditingController controllerConfirmPwd;
  bool isErrorUsername;
  bool isErrorEmail;
  bool isErrorPassword;
  bool isErrorConfirmPwd;
  String errorTypeUsername;
  String errorTypeEmail;
  String errorTypePassword;
  String errorTypeConfirmPwd;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.formKey,
    required this.validateSignUp,
    required this.controllerUsername,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.controllerConfirmPwd,
    required this.isErrorUsername,
    required this.isErrorEmail,
    required this.isErrorPassword,
    required this.isErrorConfirmPwd,
    required this.errorTypeUsername,
    required this.errorTypeEmail,
    required this.errorTypePassword,
    required this.errorTypeConfirmPwd
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: global.secondary,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
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
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Inscription",
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controllerUsername,
                            isError: isErrorUsername,
                            errorType: errorTypeUsername,
                            hintText: "Nom d'utilisateur",
                            icon: const Icon(
                              Icons.person,
                              size: 22,
                              color: Colors.grey,
                            )
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: controllerEmail,
                            isError: isErrorEmail,
                            errorType: errorTypeEmail,
                            hintText: "Email",
                            icon: const Icon(
                              Icons.email,
                              size: 22,
                              color: Colors.grey,
                            )
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: controllerPassword,
                            isError: isErrorPassword,
                            errorType: errorTypePassword,
                            hintText: "Mot de passe",
                            icon: const Icon(
                              Icons.lock,
                              size: 22,
                              color: Colors.grey,
                            )
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: controllerConfirmPwd,
                            isError: isErrorConfirmPwd,
                            errorType: errorTypeConfirmPwd,
                            hintText: "Confirmer mot de passe",
                            icon: const Icon(
                              Icons.lock,
                              size: 22,
                              color: Colors.grey,
                            )
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                callbackFunction: () {
                                  context.go('/login');
                                },
                                text: 'RETOUR',
                                backgroundColor: Colors.white,
                                textColor: global.tertiary,
                                height: 50,
                                width: constraints.maxWidth / 2 - 40
                              ),
                              const SizedBox(width: 20),
                              CustomButton(
                                callbackFunction: () {
                                  validateSignUp();
                                },
                                text: 'S\'INSCRIRE',
                                backgroundColor: global.tertiary,
                                textColor: Colors.white,
                                height: 50,
                                width: constraints.maxWidth / 2 - 40
                              ),
                            ]
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