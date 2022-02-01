import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/bsc_address_page.dart';
import 'route_generator.dart';
import 'services/token_service.dart';
import 'services/user_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(
          create: (_) => UserService(),
        ),
        ChangeNotifierProvider<TokenService>(
          create: (_) => TokenService(),
        ),
      ],
      child: MaterialApp(
        title: 'CHEEMS PETS',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Montserrat',
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: BscAddressPage.routeID,
      ),
    );
  }
}
