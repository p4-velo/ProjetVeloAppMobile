import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;

class MobileView {
  BuildContext context;
  bool isLoading;
  dynamic fNameKey;
  dynamic lNameKey;
  dynamic usernameKey;
  dynamic emailKey;
  dynamic password1;
  dynamic password2;

  MobileView({
    required this.context,
    required this.isLoading,
    required this.fNameKey,
    required this.lNameKey,
    required this.usernameKey,
    required this.emailKey,
    required this.password1,
    required this.password2,
  });

  render() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          backgroundColor: global.secondary,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Image.asset(
                      //'assets/images/djon-metropole.png',
                      //width: 200,
                    //),
                    Form(
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Form(
                            key: fNameKey,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Renseignez ce champ';
                                  }
                                  print("Prénom : " + value);
                                  return null;
                                },
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
                          Form(
                            key: lNameKey,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Renseignez ce champ';
                                  }
                                  print("Nom : " + value);
                                  return null;
                                },
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
                          Form(
                            key: usernameKey,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Renseignez ce champ';
                                  }
                                  print("Username : " + value);
                                  return null;
                                },
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
                          Form(
                            key: emailKey,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Renseignez ce champ';
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
                          Form(
                            key: password1,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Renseignez ce champ';
                                  }
                                  print("Mot de Passe : " + value);
                                  return null;
                                },
                                cursorColor: const Color(0xFF102a5b),
                                obscureText: true,
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
                          Form(
                            key: password2,
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.1),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "\tRenseignez ce champ";
                                  }
                                  print("Mot de Passe (confirmation): " + value);
                                  return null;
                                },
                                cursorColor: const Color(0xFF102a5b),
                                obscureText: true,
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
                          
                          Row(
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
                                        onTap: () {
                                          context.go('/login');
                                        },
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Material(
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.height * 0.1,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        print("\nInscription :");
                                        if ( (fNameKey.currentState!.validate()) 
                                        && (lNameKey.currentState!.validate()) 
                                        && (usernameKey.currentState!.validate()) 
                                        && (emailKey.currentState!.validate())
                                        && (password1.currentState!.validate())
                                        && (password2.currentState!.validate())) {
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