import 'package:cheemspets/services/token_service.dart';
import 'package:cheemspets/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'feedback_page.dart';
import 'home_page.dart';
import 'poll_page.dart';
import 'setting_page.dart';

class BscWalletPage extends StatefulWidget {
  static const String routeID = 'bsc_wallet_page';
  const BscWalletPage({Key? key}) : super(key: key);

  @override
  State<BscWalletPage> createState() => _BscWalletPageState();
}

class _BscWalletPageState extends State<BscWalletPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tokenService = Provider.of<TokenService>(context);
    final userService = Provider.of<UserService>(context);

    List<Widget> _widgetOptions = <Widget>[
      const HomePage(),
      const ExchangePage(),
      const PromotedCoinsPage(),
      const SettingPage(),
    ];
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          elevation: 10.0,
          child: _bottomNavigationBar(tokenService, userService),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget _bottomNavigationBar(
      TokenService tokenService, UserService userService) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: FaIcon(
            FontAwesomeIcons.wallet,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: FaIcon(
            FontAwesomeIcons.eye,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: FaIcon(
            FontAwesomeIcons.list,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.black,
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        if (tokenService.tokenLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Loading Data Please Wait'),
            ),
          );
          return;
        }
        if (index == 0) {
          tokenService.tokenLoading = true;
        } else if (index == 1) {
          tokenService.metaManInfoLoading = true;
        }
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
