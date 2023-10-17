// ignore_for_file: library_private_types_in_public_api, must_be_immutable, duplicate_ignore, use_build_context_synchronously
import 'package:bagwan/models/CargoDetailsScreen.dart';
import 'package:bagwan/models/containerDetails.dart';
import 'package:bagwan/models/models.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class FirestoreDataScreen extends StatefulWidget {
  const FirestoreDataScreen({super.key});

  @override
  State<FirestoreDataScreen> createState() => _FirestoreDataScreenState();
}

class _FirestoreDataScreenState extends State<FirestoreDataScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isUploading = false;
  String selectedClass = 'Container';
  void setSelectedClass(String className) {
    setState(() {
      selectedClass = className;
    });
  }

  Color getButtonColor(String className) {
    return className == selectedClass
        ? const Color.fromARGB(255, 4, 28, 104)
        : const Color.fromARGB(255, 240, 235, 235);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text('SHIPMENTS', style: TextStyle(fontFamily: "Times New Roman",)),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(h * 0.05),
              child: Wrap(
                children: [
                  TextButton(
                    onPressed: () {
                      setSelectedClass('Container');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: getButtonColor('Container'),
                    ),
                    child: const Text("Container", style: TextStyle(fontFamily: "Times New Roman",)),
                  ),
                  SizedBox(width: w * 0.01),
                  TextButton(
                    onPressed: () {
                      setSelectedClass('Loose cargo');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: getButtonColor('Loose cargo'),
                    ),
                    child: const Text("Loose cargo", style: TextStyle(fontFamily: "Times New Roman",)),
                  ),
                  SizedBox(width: w * 0.01),
                  TextButton(
                    onPressed: () {
                      setSelectedClass('Abnormal');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: getButtonColor('Abnormal'),
                    ),
                    child: const Text("Abnormal", style: TextStyle(fontFamily: "Times New Roman",)),
                  ),
                  SizedBox(width: w * 0.01),
                  TextButton(
                    onPressed: () {
                      setSelectedClass('Fuel');
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: getButtonColor('Fuel'),
                    ),
                    child: const Text("Fuel",style: TextStyle(fontFamily: "Times New Roman",)),
                  ),
                ],
              ))),
      body: _buildBody(selectedClass),
    );
  }
}

Widget _buildBody(String selectedClass) {
  switch (selectedClass) {
    case 'Container':
      return ContainerC(
        dataScreen: _FirestoreDataScreenState(),
      );
    case 'Loose cargo':
      return LooseCargo(dataScreen: _FirestoreDataScreenState());
    case 'Abnormal':
      return Abnormal(dataScreen: _FirestoreDataScreenState());
    case 'Fuel':
      return Fuel(
        dataScreen: _FirestoreDataScreenState(),
      );
    default:
      return const Center(
        child: Text('Select the the type of shipment.',style: TextStyle(fontFamily: "Times New Roman",)),
      );
  }
}

class ContainerC extends StatelessWidget {
  final _FirestoreDataScreenState dataScreen;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool isloading = false;

  ContainerC({super.key, required this.dataScreen});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .collection('myorders')
            .where('containerSelected', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Image(
                image: const AssetImage('assets/nothing.gif'),
                height: h * 0.35,
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var doc = docs[index];
              var data = doc.data() as Map<String, dynamic>;
              final documentId = doc.id;
              final timestamp = data['timestamp'] as Timestamp;
              final formattedDateTime =
                  DateFormat('yyyy-MM-dd     HH:mm').format(timestamp.toDate());

              final List<String> route = (data['route'] as String).split(', ');

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContainerDetails(
                        formattedDateTime: formattedDateTime,
                        selectedDestination: data['selectedDestination'],
                        selectedDestinationPrice:
                            data['selectedDestinationPrice'].toStringAsFixed(0),
                        selectedRate: data['selectedRate'],
                        carDetails: data['carDetails'],
                        models: Models(),
                        documentId: documentId,
                        route: route,
                        selectedType: 'selectedtype',
                        numberContainer: 'numberContainer',
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Container',style: TextStyle(fontFamily: "Times New Roman",)),
                        Text('Date: $formattedDateTime', style: const TextStyle(fontFamily: "Times New Roman",)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LooseCargo extends StatelessWidget {
  final _FirestoreDataScreenState dataScreen;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool isloading = false;

  LooseCargo({super.key, required this.dataScreen});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .collection('myorders')
            .where('loosecargoSelected', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Image(
                image: const AssetImage('assets/nothing.gif'),
                height: h * 0.35,
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var doc = docs[index];
              var data = doc.data() as Map<String, dynamic>;
              final documentId = doc.id;
              final timestamp = data['timestamp'] as Timestamp;
              final formattedDateTime =
                  DateFormat('yyyy-MM-dd     HH:mm').format(timestamp.toDate());
              final List<String> route = (data['route'] as String).split(', ');

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CargoDetailsScreen(
                        formattedDateTime: formattedDateTime,
                        selectedDestination: data['selectedDestination'],
                        selectedDestinationPrice:
                            data['selectedDestinationPrice'].toStringAsFixed(0),
                        selectedRate: data['selectedRate'],
                        carDetails: data['carDetails'],
                        models: Models(),
                        documentId: documentId,
                        route: route,
                        transitType: data['transitType'],
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cargo details', style: TextStyle(fontFamily: "Times New Roman",)),
                        Text('Date: $formattedDateTime', style:const TextStyle(fontFamily: "Times New Roman",)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Abnormal extends StatelessWidget {
  final _FirestoreDataScreenState dataScreen;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool isloading = false;

  Abnormal({super.key, required this.dataScreen});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .collection('myorders')
            .where('abnormalSelected', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Image(
                image: const AssetImage('assets/nothing.gif'),
                height: h * 0.35,
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var doc = docs[index];
              var data = doc.data() as Map<String, dynamic>;
              final documentId = doc.id;
              final timestamp = data['timestamp'] as Timestamp;
              final formattedDateTime =
                  DateFormat('yyyy-MM-dd     HH:mm').format(timestamp.toDate());
              final List<String> route = (data['route'] as String).split(', ');

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CargoDetailsScreen(
                        formattedDateTime: formattedDateTime,
                        selectedDestination: data['selectedDestination'],
                        selectedDestinationPrice:
                            data['selectedDestinationPrice'].toStringAsFixed(0),
                        selectedRate: data['selectedRate'],
                        carDetails: data['carDetails'],
                        models: Models(),
                        documentId: documentId,
                        route: route,
                         transitType: data['transitType'],
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cargo details',style: TextStyle(fontFamily: "Times New Roman",)),
                        Text('Date: $formattedDateTime',style: const TextStyle(fontFamily: "Times New Roman",) ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Fuel extends StatelessWidget {
  final _FirestoreDataScreenState dataScreen;
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool isloading = false;

  Fuel({super.key, required this.dataScreen});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('orders')
            .doc(uid)
            .collection('myorders')
            .where('fuelSelected', isEqualTo: true)
            .orderBy('timestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(
              child: Image(
                image: const AssetImage('assets/nothing.gif'),
                height: h * 0.35,
              ),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var doc = docs[index];
              var data = doc.data() as Map<String, dynamic>;
              final documentId = doc.id;
              final timestamp = data['timestamp'] as Timestamp;
              final formattedDateTime =
                  DateFormat('yyyy-MM-dd     HH:mm').format(timestamp.toDate());
              final List<String> route = (data['route'] as String).split(', ');

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CargoDetailsScreen(
                        formattedDateTime: formattedDateTime,
                        selectedDestination: data['selectedDestination'],
                        selectedDestinationPrice:
                            data['selectedDestinationPrice'].toStringAsFixed(0),
                        selectedRate: data['selectedRate'],
                        carDetails: data['carDetails'],
                        models: Models(),
                        documentId: documentId,
                        route: route,
                         transitType: data['transitType'],
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Cargo details', style: TextStyle(fontFamily: "Times New Roman",)),
                        Text('Date: $formattedDateTime', style:const TextStyle(fontFamily: "Times New Roman",)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
