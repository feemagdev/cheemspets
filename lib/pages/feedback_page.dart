import 'package:cheemspets/services/token_service.dart';
import 'package:cheemspets/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExchangePage extends StatelessWidget {
  const ExchangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tokenService = Provider.of<TokenService>(context);
    final userService = Provider.of<UserService>(context);

    if (tokenService.metaManInfoLoading) {
      String currecncy = userService.sharedPreferences.getString('currency')!;
      tokenService.getMetaManCoinInfo2(currecncy);
    }
    return tokenService.metaManInfoLoading
        ? Scaffold(
            body: Center(
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(
                  strokeWidth: 3.0,
                ),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/track.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.61,
                    width: MediaQuery.of(context).size.width,
                  ),
                  const Text(
                    'CHEEMSPET\$',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${userService.sharedPreferences.getString('currency_symbol')}' +
                        tokenService.metaManInfo!.price,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
  }
}
