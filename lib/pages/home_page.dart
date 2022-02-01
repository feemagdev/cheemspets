import 'dart:math';

import 'package:cheemspets/models/token_market_model.dart';
import 'package:cheemspets/services/token_service.dart';
import 'package:cheemspets/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userService = Provider.of<UserService>(context);
    final tokenService = Provider.of<TokenService>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.jpeg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  _getName(userService),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.30,
            child: Stack(
              children: [
                Positioned(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Image.asset(
                    'assets/images/data.png',
                    width: MediaQuery.of(context).size.width * 0.80,
                  ),
                ),
                _getBalanceDetails(tokenService, userService, size, context)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _getTokens(
              tokenService,
              userService.sharedPreferences.getString('currency_symbol'),
              userService,
              context)
        ],
      ),
    );
  }

  // Widget _getName(UserService userService) {
  //   String? name = userService.sharedPreferences.getString('user_name');
  //   if (name == null) {
  //     return const Text('');
  //   }
  //   return Text(
  //     'Hi $name!',
  //     textScaleFactor: 1.2,
  //     style:
  //         TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
  //   );
  // }

  Widget _balanceUI(Size size, double result, double priceChangeIn24h,
      String currency, String currencyCode, context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.13,
        // ),
        const SizedBox(
          height: 55.0,
        ),
        const Text(
          'Portfolio',
          textScaleFactor: 0.7,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          'Total $currency Value',
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 0.8,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          '$currencyCode ${NumberFormat.decimalPattern().format(result)}',
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.0,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'change in 24h',
              textScaleFactor: 0.7,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 5.0,
            ),
            const Text(
              '|',
              overflow: TextOverflow.ellipsis,
              textScaleFactor: 0.7,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 3.0, right: 3.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      priceChangeIn24h.toStringAsFixed(1),
                      textScaleFactor: 0.7,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: priceChangeIn24h.isNegative
                              ? Colors.red
                              : Colors.green),
                    ),
                    Text(
                      '%',
                      textScaleFactor: 0.7,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: priceChangeIn24h.isNegative
                              ? Colors.red
                              : Colors.green),
                    ),
                    priceChangeIn24h.isNegative
                        ? const Icon(
                            Icons.arrow_downward_outlined,
                            color: Colors.red,
                            size: 8.0,
                          )
                        : const Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.green,
                            size: 8.0,
                          ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _getBalanceDetails(
      TokenService tokenService, UserService userService, Size size, context) {
    String? bscAddress = userService.sharedPreferences.getString('bsc_address');

    if (tokenService.tokenLoading) {
      tokenService.getTokens(bscAddress!);
      return Container();
    } else {
      return _balanceUI(
          size,
          tokenService.totaCurrenctlValue,
          tokenService.change24hPercent,
          userService.sharedPreferences.getString('currency')!,
          userService.sharedPreferences.getString('currency_symbol')!,
          context);
    }
  }

  Widget _getTokens(TokenService tokenService, String? currencyCode,
      UserService userService, context) {
    if (tokenService.tokenLoading) {
      return Center(
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
      );
    } else {
      tokenService.tokenMarketData
          .sort((a, b) => b.marketCap.compareTo(a.marketCap));
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height * 0.50,
        child: Container(
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
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: tokenService.tokenMarketData.length,
                itemBuilder: (context, index) {
                  TokenMarketModel marketModel =
                      tokenService.tokenMarketData[index];
                  double totalValue =
                      (tokenService.tokenMarketData[index].currentPrice *
                          (double.parse(marketModel.balance) /
                              pow(10, marketModel.contractDecimals)));
                  if (!userService.sharedPreferences
                      .getBool(marketModel.symbol)!) {
                    return const SizedBox();
                  }
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          tokenService.getTokenChangePercent('1D', marketModel);
                          _showModal(context, marketModel);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // right part
                              Row(
                                children: [
                                  marketModel.id == 'CHEEMSPETS'
                                      ? Image.asset(
                                          'assets/images/logo.png',
                                          width: 30.0,
                                        )
                                      : Image.network(
                                          marketModel.image,
                                          width: 20.0,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/logo.png',
                                              width: 20.0,
                                            );
                                          },
                                        ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.30,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          marketModel.name,
                                          textScaleFactor: 0.6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          marketModel.symbol,
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                          textScaleFactor: 0.5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              //left part
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$currencyCode ${NumberFormat.decimalPattern().format(totalValue)}',
                                    textScaleFactor: 0.6,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    NumberFormat.compact(locale: 'en_US')
                                        .format(
                                      (double.parse(marketModel.balance) /
                                          pow(10,
                                              marketModel.contractDecimals)),
                                    ),
                                    style: TextStyle(color: Colors.grey[500]),
                                    textScaleFactor: 0.5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.black26,
                        thickness: 0.2,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
  }

  void _showModal(BuildContext context, TokenMarketModel tokenMarketData) {
    final userService = Provider.of<UserService>(context, listen: false);
    final tokenService = Provider.of<TokenService>(context, listen: false);
    String currecny = userService.sharedPreferences.getString('currency')!;
    String currecnySymbol =
        userService.sharedPreferences.getString('currency_symbol')!;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // coin icon name and close button icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // right part
                    Row(
                      children: [
                        tokenMarketData.id == 'CHEEMSPETS'
                            ? Image.asset(
                                'assets/images/logo.png',
                                width: 30.0,
                              )
                            : Image.network(
                                tokenMarketData.image,
                                width: 30.0,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/logo.png',
                                    width: 30.0,
                                  );
                                },
                              ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tokenMarketData.name,
                              textScaleFactor: 1.2,
                            ),
                            Text(
                              tokenMarketData.symbol,
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        )
                      ],
                    ),
                    // CLOSE BUTTON
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 17.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('price'),
                      Text('$currecnySymbol${tokenMarketData.currentPrice}'),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total ${tokenMarketData.symbol}'),
                      Text((double.parse(tokenMarketData.balance) /
                              pow(10, tokenMarketData.contractDecimals))
                          .toStringAsFixed(2)),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total $currecny value'),
                      Text(
                          '$currecnySymbol${(tokenMarketData.currentPrice * (double.parse(tokenMarketData.balance) / pow(10, tokenMarketData.contractDecimals))).toStringAsFixed(2)}'),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Market Cap'),
                      Text(
                        '$currecnySymbol ${NumberFormat.decimalPattern().format(tokenMarketData.marketCap)}',
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.black26,
                  thickness: 0.2,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('% Change'),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: 40.0,
                            child: TextButton(
                              onPressed: () {
                                tokenService.getTokenChangePercent(
                                    '1D', tokenMarketData);
                                setState(() {});
                              },
                              child: const Text('1D'),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: 40.0,
                            child: TextButton(
                              onPressed: () {
                                tokenService.getTokenChangePercent(
                                    '1W', tokenMarketData);
                                setState(() {});
                              },
                              child: const Text('1W'),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200),
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          SizedBox(
                            width: 40.0,
                            child: TextButton(
                              onPressed: () {
                                tokenService.getTokenChangePercent(
                                    '1M', tokenMarketData);
                                setState(() {});
                              },
                              child: const Text('1M'),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200),
                            ),
                          ),
                        ],
                      ),
                      Text(tokenService.selectedPerecet.toStringAsFixed(2)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
