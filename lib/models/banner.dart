
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  BannerWidgetState createState() => BannerWidgetState();
}

class BannerWidgetState extends State<BannerWidget> {
  bool isExpanded = true;

  void toggleBanner() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        if (isExpanded)
          Container(
            width: w,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 28, 104),
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(h * 0.05),
                    topRight: Radius.circular(h * 0.05))),
            
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'BANK DETAILS',
                    style: TextStyle(color: Colors.white, fontSize: 18.0,  fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'EQUITY BANK',
                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                ),
                Text(
                  'AC NAME: BAGWAN CARGO AND LOGISTICS',
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                ),
                Text(
                  'AC No:   3004211860983',
                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                ),
                Text(
                  'BRANCH CODE:   3004',
                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                ),
                                Text(
                  'SWIFT CODE:   EQBLTZTZ',
                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                ),
                                Text(
                  'SORT CODE:   047004',
                  style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: "Times New Roman", fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: toggleBanner,
           child: Text(isExpanded ? 'Hide' : 'Expand'),
        ),
      ],
    );
  }
}
