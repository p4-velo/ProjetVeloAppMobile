import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    //Image.asset(
                      //'assets/images/djon-metropole.png',
                      //width: 200,
                    //),
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
                                  "Inscription",
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
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                cursorColor: const Color(0xFF102a5b),
                                decoration: InputDecoration(
                                  hintText: "Prénom",
                                  hintStyle: GoogleFonts.ptSans(
                                    textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                cursorColor: const Color(0xFF102a5b),
                                decoration: InputDecoration(
                                  hintText: "Nom",
                                  hintStyle: GoogleFonts.ptSans(
                                    textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
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
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                cursorColor: const Color(0xFF102a5b),
                                decoration: InputDecoration(
                                  hintText: "Nom d'utilisateur",
                                  hintStyle: GoogleFonts.ptSans(
                                    textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_4,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                cursorColor: const Color(0xFF102a5b),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.ptSans(
                                    textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
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
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                cursorColor: const Color(0xFF102a5b),
                                decoration: InputDecoration(
                                  hintText: "Mot de passe",
                                  hintStyle: GoogleFonts.ptSans(
                                    textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                cursorColor: const Color(0xFF102a5b),
                                decoration: InputDecoration(
                                  hintText: "Confirmer mot de passe",
                                  hintStyle: GoogleFonts.ptSans(
                                    textStyle: TextStyle(color: Colors.grey, fontSize: 18),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
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
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ),
                          SizedBox( // right one
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [ 
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.1,
                                        ),
                                        child: InkWell(
                                          //onTap: () {
                                            //Navigator.push(
                                            //context
                                            //MaterialPageRoute(builder: (context) => const SignIn()),
                                          //);
                                          //},
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
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            child: Center(
                                              child: Text(
                                                "< RETOUR",
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
                                SizedBox( // left one
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Padding( 
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height * 0.1,
                                        ),
                                        child: InkWell(
                                          /*onTap: () {
                                            Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const FavoritesAdress()),
                                          );
                                          },*/
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
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            height: MediaQuery.of(context).size.height * 0.05,
                                            child: Center(
                                              child: Text(
                                                "S'INSCRIRE >",
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
                              ]
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