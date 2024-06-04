import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileView {
  BuildContext context;
  bool isLoading;
  dynamic emailKey;
  dynamic passwordKey;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.emailKey,
    required this.passwordKey,
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: const Color(0xFF102a5b),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Connexion",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Form(
                            key: emailKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.1),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Renseignez ce champ";
                                    }
                                    print("eMail : " + value);
                                    return null;
                                  },
                                  cursorColor: const Color(0xFF102a5b),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: GoogleFonts.ptSans(
                                      textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      size: MediaQuery.of(context).size.width * 0.06,
                                      color: Colors.grey,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width * 0.12,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width * 0.1),
                                      ),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width * 0.1),
                                      ),
                                      borderSide: BorderSide(
                                        color: const Color(0xff445a80),
                                        width:
                                            MediaQuery.of(context).size.width * 0.008,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Form(
                            key: passwordKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.1),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Renseignez ce champ";
                                    }
                                    print("Mot de Passe : " + value);
                                    return null;
                                  },
                                  cursorColor: const Color(0xFF102a5b),
                                  decoration: InputDecoration(
                                    hintText: "Mot de passe",
                                    hintStyle: GoogleFonts.ptSans(
                                      textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      size: MediaQuery.of(context).size.width * 0.06,
                                      color: Colors.grey,
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: MediaQuery.of(context).size.width * 0.12,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width * 0.1),
                                      ),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            MediaQuery.of(context).size.width * 0.1),
                                      ),
                                      borderSide: BorderSide(
                                        color: const Color(0xff445a80),
                                        width: MediaQuery.of(context).size.width * 0.008,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Padding( 
                            padding: const EdgeInsets.only(right: 32, left: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.1,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      print("\nInscription :");
                                        if ( (emailKey.currentState!.validate()) 
                                        && (passwordKey.currentState!.validate())) {
                                          print("Tous les champs ont été complétés");
                                        } else {
                                          print("Un champ ou plus est manquant");
                                        }
                                    },
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height * 0.1,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xff445a80),
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.1,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: Center(
                                        child: Text(
                                          "SE CONNECTER",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1, right:1),
                            child: Row(
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height * 0.1,
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height * 0.1,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.1,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      child: Center(
                                        child: Text(
                                          "CRÉER MON COMPTE",
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              color:Color(0xff445a80),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}