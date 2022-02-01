import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cheemspets/services/user_service.dart';
import 'package:currency_picker/currency_picker.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bsc_address_page.dart';
import 'token_visibility_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: true);
    return Scaffold(
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
                height: 5.0,
              ),
              Text(
                'Options',
                textScaleFactor: 2.0,
                style: TextStyle(
                    color: Colors.blue.shade900, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10.0,
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
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                showCurrencyPicker(
                                  context: context,
                                  showFlag: true,
                                  showCurrencyName: true,
                                  showCurrencyCode: true,
                                  onSelect: (Currency currency) {
                                    userService.changeCurrency(
                                        currency: currency.code,
                                        currencySymbol: currency.symbol);
                                  },
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // currency and icon
                                  SizedBox(
                                    height: 30.0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.monetization_on_outlined,
                                          color: Colors.orange,
                                          size: 10.0,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Change Currency',
                                          textScaleFactor: 0.7,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // currency name and forward icon
                                  Row(
                                    children: [
                                      Text(
                                        userService.sharedPreferences
                                            .getString('currency')!,
                                        textScaleFactor: 0.7,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10.0,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, TokenVisibility.routeID);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 30.0,
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.visibility_outlined,
                                          color: Colors.orange,
                                          size: 10.0,
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          'Token Visibility',
                                          textScaleFactor: 0.7,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10.0,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            InkWell(
                              onTap: () {
                                _showWarningDialog(context, userService);
                              },
                              child: SizedBox(
                                height: 30.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.orange,
                                      size: 10.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Clear App Data',
                                      textScaleFactor: 0.7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            InkWell(
                              onTap: () async {
                                const String _url =
                                    'https://t.me/cheemspetstechsupport';
                                await _launchURL(context, _url);
                              },
                              child: SizedBox(
                                height: 30.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.help_outline,
                                      color: Colors.orange,
                                      size: 10.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'Help & Support',
                                      textScaleFactor: 0.7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            InkWell(
                              onTap: () async {
                                const String _url =
                                    'https://www.cheemspets.com/';
                                await _launchURL(context, _url);
                              },
                              child: SizedBox(
                                height: 30.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.report_outlined,
                                      color: Colors.orange,
                                      size: 10.0,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      'About',
                                      textScaleFactor: 0.7,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // const Text(
                      //   'CHEEMS PETS',
                      //   textScaleFactor: 1.2,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: TextStyle(
                      //       fontFamily: 'Montserrat-ExtraBold',
                      //       fontWeight: FontWeight.bold),
                      // ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     const String _url =
                      //         'https://poocoin.app/tokens/0x27f8de08ab90d5D1e83E30FEe8603d0D1C317326';
                      //     await _launchURL(context, _url);
                      //   },
                      //   child: Image.asset(
                      //     'assets/images/logo.png',
                      //     width: 75,
                      //     height: 75,
                      //     alignment: Alignment.centerLeft,
                      //   ),
                      // )
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

  void _showWarningDialog(BuildContext context, UserService userService) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      btnOkText: 'DELETE',
      btnCancelText: 'CANCEL',
      title: 'Hol Up!',
      desc:
          'Clearing data will reset app. you will have to connect your wallet again to continue using the app',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        userService.sharedPreferences.clear();
        Navigator.pushReplacementNamed(context, BscAddressPage.routeID);
      },
    ).show();
  }

  Future<void> _launchURL(context, url) async {
    if (!await launch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch website'),
        ),
      );
    }
  }
}
