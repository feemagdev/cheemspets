import 'package:bordered_text/bordered_text.dart';
import 'package:cheemspets/services/token_service.dart';
import 'package:cheemspets/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_drawer.dart';

class UserNamePage extends StatelessWidget {
  static const String routeID = 'username_page';
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokenService = Provider.of<TokenService>(context);
    final userService = Provider.of<UserService>(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: GestureDetector(
        onTap: () async {
          userService.sharedPreferences
              .setString('user_name', _userNameController.text);
          tokenService.tokenLoading = true;

          _moveToWalletPage(
            context,
          );
        },
        child: Image.asset(
          'assets/images/next.png',
          width: 50,
          height: 60,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.of(context).size.width * 0.80,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              BorderedText(
                strokeWidth: 5.0,
                strokeColor: Colors.blue,
                child: const Text(
                  'WELCOME!',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'TO CHEEMSPETS',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'HEY WHAT DO WE CALL YOU?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 10.0,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue.shade800,
                  border: Border.all(
                    color: Colors.blue.shade800,
                    width: 25.0,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.blue.shade400,
                      width: 15.0,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: 'Your Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _moveToWalletPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(BscWalletPage.routeID);
  }
}
