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
                      child: Column( // colonne principale
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Adresses favorites",
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
                            child: Column( // colonne adresse 1
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "MAISON",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 24,
                                          color: const Color(0xFF102a5b),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0),
                                            child:Icon(
                                              Icons.edit,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: const Color(0xFF102a5b)
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.03), // Espacement entre élément 1 et élément 2
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0),
                                            child:Icon(
                                              Icons.delete,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: const Color(0xFF102a5b)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Form(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "35 rue Béranger, 21000 Dijon",
                                        style: GoogleFonts.ptSans(
                                          textStyle: const TextStyle(color: Color(0xff445a80), fontSize: 18)
                                        )
                                      )
                                    ],
                                  )
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0),
                                  child: Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xff445a80),
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                          border: Border.all(color: Color(0xff445a80)),
                                        ),
                                        height: MediaQuery.of(context).size.width * 0.08,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 32),
                                              child: Text(
                                                "AFFICHER SUR LA CARTE",
                                                style: GoogleFonts.ptSans(
                                                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 32),
                                              child:Icon(
                                                Icons.location_on,
                                                size: MediaQuery.of(context).size.width * 0.06,
                                                color: Colors.white,
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

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Column( // colonne adresse 2
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "TRAVAIL",
                                        style: GoogleFonts.ptSans(
                                          textStyle: const TextStyle(color: Color(0xFF102a5b), fontSize: 24, fontWeight: FontWeight.bold)
                                        )
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0),
                                            child:Icon(
                                              Icons.edit,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: const Color(0xFF102a5b)
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.03), // Espacement entre élément 1 et élément 2
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0),
                                            child:Icon(
                                              Icons.delete,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: const Color(0xFF102a5b)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Form(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "26 Bd. Georges Clémenceau, 21000 Dijon",
                                        style: GoogleFonts.ptSans(
                                          textStyle: const TextStyle(color: Color(0xff445a80), fontSize: 18)
                                        )
                                      )
                                    ],
                                  )
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0),
                                  child: Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xff445a80),
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                          border: Border.all(color: Color(0xff445a80)),
                                        ),
                                        height: MediaQuery.of(context).size.width * 0.08,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 32),
                                              child: Text(
                                                "AFFICHER SUR LA CARTE",
                                                style: GoogleFonts.ptSans(
                                                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 32),
                                              child:Icon(
                                                Icons.location_on,
                                                size: MediaQuery.of(context).size.width * 0.06,
                                                color: Colors.white,
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Column( // colonne adresse 2
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "SALLE DE SPORT",
                                        style: GoogleFonts.ptSans(
                                          textStyle: const TextStyle(color: Color(0xFF102a5b), fontSize: 24, fontWeight: FontWeight.bold)
                                        )
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0),
                                            child:Icon(
                                              Icons.edit,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: const Color(0xFF102a5b)
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.03), // Espacement entre élément 1 et élément 2
                                          Padding(
                                            padding: const EdgeInsets.only(right: 0),
                                            child:Icon(
                                              Icons.delete,
                                              size: MediaQuery.of(context).size.width * 0.06,
                                              color: const Color(0xFF102a5b)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                                Form(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "56 Avenue du Drapeau, 21000 Dijon",
                                        style: GoogleFonts.ptSans(
                                          textStyle: const TextStyle(color: Color(0xff445a80), fontSize: 18)
                                        )
                                      )
                                    ],
                                  )
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0),
                                  child: Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xff445a80),
                                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                                          border: Border.all(color: Color(0xff445a80)),
                                        ),
                                        height: MediaQuery.of(context).size.width * 0.08,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 32),
                                              child: Text(
                                                "AFFICHER SUR LA CARTE",
                                                style: GoogleFonts.ptSans(
                                                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 32),
                                              child:Icon(
                                                Icons.location_on,
                                                size: MediaQuery.of(context).size.width * 0.06,
                                                color: Colors.white,
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

                        ]
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}