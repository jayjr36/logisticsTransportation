import 'package:bagwan/company.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        toolbarHeight: h * 0.15,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 4, 28, 104),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(h * 0.1),
              bottomRight: Radius.circular(h * 0.1),
            ),
          ),
          child: const Center(
            child: Image(image: AssetImage('assets/bcl.png')),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.1),
        child: Column(
          children: [
            const Text(
              "ABOUT US",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontFamily: "Times New Roman",
                  fontSize: 24),
            ),
            const Text(
                "Bagwan cargo and Logistics is a heavy Duty Transportation and freight clearing Company. Our area of expertise is across the whole of East and Central Africa. This is because of the good indigenous knowledge of the Area and our strong interaction with the local societies. We transit within Tanzania and the whole region of East & Central Africa. Our specialization in Goods transportation includes variety of goods from different classes such as Loose cargo, Sealed cargo, Containers,Heavy duty goods",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                )),
            SizedBox(
              height: h * 0.06,
            ),
            const Text(
              "  Contact us",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text("+255-6779-97372",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                )),
            const Text("+255-7457-69590",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                )),
            const Text("johnsilayo309@gmail.com",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                )),
            const Text("www.bagwancargologistic.co.tz",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                )),
            const Text("Olympio road opposite CBE",
                style: TextStyle(
                  fontFamily: "Times New Roman",
                )),
            SizedBox(
              height: h * 0.04,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Company()));
              },
              child: const Text(
                'Visit our profile',
                style: TextStyle(
                    color: Colors.blue,
                    fontFamily: "Times New Roman",
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Center(
              child: Expanded(
                  child: Column(
                children: [
                  const Text('FOLLOW US',
                      style: TextStyle(
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.bold)),
                  Wrap(
                    children: [
                      Image.asset(
                        'assets/ig.png',
                        width: h * 0.035,
                        height: h * 0.035,
                      ),
                      Image.asset(
                        'assets/fb.png',
                        width: h * 0.03,
                        height: h * 0.03,
                      ),
                      Image.asset(
                        'assets/youtube.png',
                        width: h * 0.03,
                        height: h * 0.03,
                      ),
                      Image.asset(
                        'assets/tiktok.png',
                        width: h * 0.03,
                        height: h * 0.03,
                      ),
                    ],
                  ),
                  const Text('@bagwancargo',
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                      ))
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
