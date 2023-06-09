import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// my functions
import 'package:universe_app/functions/functions.dart';

// my providers
import 'package:provider/provider.dart';
import 'package:universe_app/pages/create_profile.dart';
import '../preferences/dark_mode_service.dart';
import '../providers/user_provider.dart';

// store stdent id and password entered by user
final TextEditingController student_id = TextEditingController();
final TextEditingController student_pass = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool isLoading = false;
  bool isDark = DarkModeService.getDarkMode();

  void toggleDarkMode() {
    setState(() {
      isDark = !isDark;
      DarkModeService.setDarkMode(isDark);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final themeData = ThemeData(brightness: isDark ? Brightness.dark : Brightness.light);

    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize:  Size.fromHeight(100),
            child: AppBar(
              // backgroundColor: const Color.fromARGB(255, 132, 94, 194),
              // backgroundColor: const Color.fromARGB(255, 97, 194, 94),
              // backgroundColor: Color.fromRGBO(10, 151, 252, 1),
              backgroundColor: primaryColor,
              title: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 25, left: 110),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'UniVerse ',
                            style: TextStyle(
                              color: Color.fromRGBO(63, 63, 63, 1),
                              fontFamily: 'Montserrat',
                              // fontFamily: 'Rubik_Pixels',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Desktop',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 28,
                              // fontStyle: FontStyle.italic
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 950,
                  ),
                  
                  // dark mode toggle
                  Container(
                    // alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 25),
                    child: ElevatedButton(
                      onPressed: () async {
                        toggleDarkMode();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: const Size(45, 45),
                        shape: const CircleBorder(
                          side: BorderSide(color: primaryColor),
                          eccentricity: 0,
                        ),
                      ),
                      child:  Icon(
                        isDark?  Icons.mode_night_rounded : Icons.light_mode,
                        color: isDark? textColorLight2 : backgroundColorLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // backgroundColor: const Color.fromRGBO(245, 244, 244, 1),
          backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
          /*black*/
          // rgba(245, 244, 244, 1)
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25, top: 120),
                child: Center(
                  child: isLoading
                      ? const Padding(
                          padding: EdgeInsets.only(top: 170),
                          child: CircularProgressIndicator(
                            // color: Color.fromARGB(255, 132, 94, 194),
                            color: primaryColor,
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              width: 410,
                              height: 400,
                              decoration: BoxDecoration(
                                // color: const Color.fromRGBO(255, 255, 255, 1),
                                color: isDark ? foregroundColorDark : backgroundColorLight,
                                /*grey*/
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark ? shadowColorDark : shadowColorLight,
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: isDark ? borderColorDark : borderColorLight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(height: 35),
                                  Text(
                                    'Welcome Back!',
                                    style: TextStyle(
                                        color: isDark ? textColorDark : textColorLight,
                                        /*white*/
                                        fontSize: 35,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'It\'s Been A Minute Since We Heard From You',
                                    style: TextStyle(
                                        color: isDark ? textColorDark : textColorLight,
                                        /*white*/
                                        fontSize: 14,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w200),
                                  ),

                                  // id field
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.75,
                                      child: TextFormField(
                                        controller: student_id,
                                        decoration: InputDecoration(
                                          labelText: 'Student Id',
                                          hintText: '########',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1), /*white*/
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
                                              /*white*/
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // password field
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.75,
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: student_pass,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  // sign in button
                                  ElevatedButton(
                                    onPressed: () async {
                                      String studentId = student_id.text;
                                      String password = student_pass.text;
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await loginUser(context, studentId, password);
                                      setState(() {
                                        isLoading = false;
                                      });
                                      student_pass.clear();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      // backgroundColor: const Color.fromARGB(255, 132, 94, 194),
                                      minimumSize: const Size(175, 65),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(0),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'sign in!',
                                      style: TextStyle(
                                          color: Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: 17,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Aren\'t a member? ',
                                    style: TextStyle(
                                      color: isDark ? textColorDark2 : textColorLight2,
                                      /*white*/
                                      fontFamily: 'Montserrat',
                                      // fontFamily: 'Rubik_Pixels',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign Up!!',
                                    style: const TextStyle(
                                      color: primaryColor,
                                      // color: Color.fromARGB(255, 132, 94, 194),
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      // fontStyle: FontStyle.italic
                                      fontWeight: FontWeight.w400,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.pushNamed(context, '/create-profile');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const CreateProfile(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
