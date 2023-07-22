import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'How to start?',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Find a suitable application or website to invest in. Suggestions: ',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent),
                  child: const Image(
                      image: NetworkImage(
                          'https://coincub.com/wp-content/uploads/2022/05/luno.png'),
                      height: 50),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent),
                  child: const Image(
                      image: NetworkImage(
                          'https://paymentsnext.com/wp-content/uploads/2019/12/etoro-logo.png'),
                      height: 30),
                ),
                Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent),
                    child: const Image(
                        image: NetworkImage(
                            'https://cdn.shortpixel.ai/spai/q_glossy+ret_img+to_auto/https://cryptogoodies.shop/wp-content/uploads/2022/02/brand-coinbase-logo.png')))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'How much money do I need to start?',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'It depends on the application or website you are using. Average is RM100: ',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent),
                      child: const Image(
                          image: NetworkImage(
                              'https://coincub.com/wp-content/uploads/2022/05/luno.png'),
                          height: 50),
                    ),
                    const Text('RM100',
                        style: TextStyle(fontSize: 17, color: Colors.white))
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent),
                      child: const Image(
                          image: NetworkImage(
                              'https://paymentsnext.com/wp-content/uploads/2019/12/etoro-logo.png'),
                          height: 30),
                    ),
                    const Text('RM220',
                        style: TextStyle(fontSize: 17, color: Colors.white))
                  ],
                ),
                Column(
                  children: [
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent),
                        child: const Image(
                            image: NetworkImage(
                                'https://cdn.shortpixel.ai/spai/q_glossy+ret_img+to_auto/https://cryptogoodies.shop/wp-content/uploads/2022/02/brand-coinbase-logo.png'))),
                    const Text('RM8',
                        style: TextStyle(fontSize: 17, color: Colors.white))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'When will I see profit?',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'It depends on the type of strategy you use in investing. If it’s long term you might not be able to get immediate profit, but it is a less risk option. If it’s short term you can get profit as fast as a few days or even a few hours, but you can lose a lot from this too.',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Tips:',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              '“Never put all your eggs in one basket”',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            const Text(
              'Diversify your portfolio by investing in multiple coins at once rather than just one coin but with a big amount of money.',
              style: TextStyle(fontSize: 17, color: Colors.white),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
