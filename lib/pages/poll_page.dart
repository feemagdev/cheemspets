import 'package:flutter/material.dart';

class PromotedCoinsPage extends StatelessWidget {
  static const String routeID = 'promoted_coins_page';

  const PromotedCoinsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.blue.shade800,
                    border: Border.all(
                      color: Colors.blue.shade800,
                      width: 25.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'PROMOTED COINS',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) =>
                              promotedCoinUI(context),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget promotedCoinUI(context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // right side

            Expanded(
              flex: 2,
              child: Container(
                height: 60,
                color: Colors.white,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 40,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'name',
                          textScaleFactor: 0.8,
                        ),
                        Text(
                          'some detail',
                          textScaleFactor: 0.6,
                        ),
                        Text(
                          'more details',
                          textScaleFactor: 0.6,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 60,
                color: Colors.white,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 8,
                  bottom: 8,
                ),
                child: Container(
                  color: Colors.grey.shade300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.grey.shade700,
                        size: 10,
                      ),
                      Text(
                        '12345',
                        textScaleFactor: 0.6,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
            // left side
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
      ],
    );
  }
}
