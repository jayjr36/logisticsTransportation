import 'package:bagwan/local.dart';
import 'package:bagwan/login.dart';
import 'package:bagwan/transit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? username;
  String? phone;
  String? email;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userData = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        username = userData['name'];
        phone = userData['phone'];
        email = userData['email'];
      });
    }
  }

    gotolocal() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) =>  Local(username: username, phone: phone,))));
  }

  gototransit() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => Transit(username: username, phone: phone,))));
  }

  final List<String> sliderImages = [
    'assets/loose.png',
    'assets/container.png',
    'assets/abnormal.png',
    'assets/fuel.png',
  ];

  final List<String> imageTexts = [
    'Loose cargo',
    'Container',
    'Abnormal cargo',
    'Fuel',
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        shadowColor: Colors.white,
        elevation: 5,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 4, 28, 104),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: h * 0.06, // Adjust the size of the avatar
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: h * 0.12, // Adjust the size of the person icon
                        color: Colors.blue, // Adjust the color of the icon
                      ),
                    ),
                    const Text(
                      'WELCOME',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Times New Roman'
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                username ?? 'Loading...',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: 'Times New Roman'
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(phone ?? 'Loading...', style:const TextStyle(fontFamily: 'Times New Roman')),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(email ?? 'Loading...', style:const TextStyle(fontFamily: 'Times New Roman'),),
            ),
            SizedBox(
              height: h * 0.43,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const Login())));
              },
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 4, 28, 104)),
                child: const ListTile(
                  title: Text(
                    "SIGN OUT",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        fontFamily: 'Times New Roman',
                        color: Colors.white),
                        
                  ),
                  trailing: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.person)),
        iconTheme: const IconThemeData(color:Colors.white),
        toolbarHeight: h * 0.18,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: h * 0.03),
        child: Column(
          children: [
            const Center(
                child: Text(
              "Welcome Aboard!",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New Roman"),
            )),
            const Center(
              child: Text(
                "Your Destination, Our Dedication!",
                style: TextStyle(fontFamily: "Times New Roman", fontSize: 16,),
              ),
            ),
            const Center(
              child: Text(
                "Deliver Beyond Expectations with Our\n              Logistics Expertise!",
                style: TextStyle(fontFamily: "Times New Roman",
                fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: h * 0.06,
            ),
            const Text(
              "Transportation services we offer",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New Roman"),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            CarouselSlider(
              items: List.generate(sliderImages.length, (index) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(h * 0.2)),
                        image: DecorationImage(
                          image: AssetImage(sliderImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(
                              h * 0.2))), // Adjust the overlay opacity
                      child: Center(
                        child: Text(
                          imageTexts[index], // Use the corresponding text
                          style:  TextStyle(
                            color: Colors.yellow.shade800,
                            fontSize: 24.0, // Adjust text size
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman'
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              options: CarouselOptions(
                height: h * 0.2,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            SizedBox(height: h * 0.05),
            const Text(
              'What\'s your destination?',
              style: TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            Wrap(
              children: [
                GestureDetector(
                  onTap: gotolocal,
                  child: Stack(
                  children: [
                    Container(
                      height: h*0.15,
                      width: w*0.4,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(h * 0.05)),
                        image: const DecorationImage(
                          image: AssetImage('assets/local.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      
                      height: h*0.15,
                      width: w*0.4,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(
                              h * 0.05))), // Adjust the overlay opacity
                      child: Padding(
                        padding: EdgeInsets.only(top: h*0.1, left: w*0.1),
                        child: Text(
                          'LOCAL', // Use the corresponding text
                          style: TextStyle(
                            color: Colors.yellow.shade800,
                            fontSize: 20.0, // Adjust text size
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman'
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                ),
                SizedBox(width: w * 0.03),
                GestureDetector(
                  onTap: gototransit,
                  child: Stack(
                  children: [
                    Container(
                      height: h*0.15,
                      width: w*0.4,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(h * 0.05)),
                        image: const DecorationImage(
                          image: AssetImage('assets/transit.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: h*0.15,
                      width: w*0.4,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(
                              h * 0.05))), // Adjust the overlay opacity
                      child:  Padding(
                        padding: EdgeInsets.only(top: h*0.1, left: w*0.1),
                        child: Text(
                          'TRANSIT', // Use the corresponding text
                          style: TextStyle(
                            color: Colors.yellow.shade800,
                            fontSize: 20.0, // Adjust text size
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times New Roman'
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
