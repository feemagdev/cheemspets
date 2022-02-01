import 'package:bordered_text/bordered_text.dart';
import 'package:cheemspets/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation_drawer.dart';
import 'user_name_page.dart';

class BscAddressPage extends StatelessWidget {
  static const String routeID = 'bsc_address_page';
  final TextEditingController _bscAddressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BscAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);

    if (userService.loading) {
      userService.getUserData();
      return const SafeArea(
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          ),
        ),
      );
    } else {
      if (userService.sharedPreferences.getKeys().isEmpty) {
        return _bscAddressUI(context);
      }
      return const BscWalletPage();
    }
  }

  void _moveToUserNamePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(UserNamePage.routeID);
  }

  Widget _bscAddressUI(context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () async {
            if (!_formKey.currentState!.validate()) {
              return;
            }
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString(
                'bsc_address', _bscAddressController.text);
            sharedPreferences.setString('currency', 'USD');
            sharedPreferences.setString('currency_symbol', '\$');

            _moveToUserNamePage(context);
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: const Text(
                    'ENTER YOUR BSC WALLET ADDRESS TO START TRACKING YOUR HOLDINGS',
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
                        controller: _bscAddressController,
                        validator: (text) {
                          if (text == null) {
                            return 'Please Enter BSC address';
                          } else if (text.length == 42) {
                            return null;
                          } else if (text.length > 42) {
                            return 'Incorrect BSC address';
                          } else if (text.length < 42) {
                            return 'Incorrect BSC address';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Your BSC Address',
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
      ),
    );
  }
}
