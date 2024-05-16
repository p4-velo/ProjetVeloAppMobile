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
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          appBar: AppBar(
            backgroundColor: const Color(0xFF102a5b), // Fond noir
            elevation: 1,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
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
                                  "Aide",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 32,
                                    color: const Color(0xFF102a5b),
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
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    border: Border.all(color: const Color(0xff445a80)),
                                  ),
                                  height: MediaQuery.of(context).size.width * 0.12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child:Icon(
                                          Icons.aod,
                                          size: MediaQuery.of(context).size.width * 0.06,
                                          color: const Color(0xff445a80),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "APPLICATION",
                                          style: GoogleFonts.ptSans(
                                            textStyle: const TextStyle(color: Color(0xFF102a5b), fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    border: Border.all(color: const Color(0xff445a80)),
                                  ),
                                  height: MediaQuery.of(context).size.width * 0.12,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child:Icon(
                                          Icons.accessibility,
                                          size: MediaQuery.of(context).size.width * 0.06,
                                          color: const Color(0xff445a80),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "ACCESSIBILITÉ",
                                          style: GoogleFonts.ptSans(
                                            textStyle: const TextStyle(color: Color(0xFF102a5b), fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    border: Border.all(color: const Color(0xff445a80)), // Bordure
                                  ),
                                  height: MediaQuery.of(context).size.width * 0.12, // Hauteur du bouton
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child:Icon(
                                          Icons.admin_panel_settings,
                                          size: MediaQuery.of(context).size.width * 0.06,
                                          color: const Color(0xff445a80),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "CONFIDENTIALITÉ ET SÉCURITÉ",
                                          style: GoogleFonts.ptSans(
                                            textStyle: const TextStyle(color: Color(0xFF102a5b), fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Material(
                              elevation: 1,
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    border: Border.all(color: const Color(0xff445a80)), // Bordure
                                  ),
                                  height: MediaQuery.of(context).size.width * 0.12, // Hauteur du bouton
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child:Icon(
                                          Icons.settings,
                                          size: MediaQuery.of(context).size.width * 0.06,
                                          color: const Color(0xff445a80),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 16),
                                        child: Text(
                                          "RÉGLAGES",
                                          style: GoogleFonts.ptSans(
                                            textStyle: const TextStyle(color: Color(0xFF102a5b), fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
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
        );
      },
    );
  }
}