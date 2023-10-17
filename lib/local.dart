// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:bagwan/shpments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class Local extends StatefulWidget {
  final String? username;
  final String? phone;
  const Local({super.key, required this.username, required this.phone});

  @override
  _LocalState createState() => _LocalState();
}

class _LocalState extends State<Local> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController destinationctrl = TextEditingController();


  bool containerSelected = false;
  bool loosecargoSelected = false;
  bool abnormalSelected = false;
  bool fuelSelected = false;
  String _selectedType = '20 ft';
  String _selectedRate = '50/50';

  String _numberContainers = '0';

  bool _showProgress = false;
  @override
  

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Local transportation',
          style: TextStyle(
            fontFamily: "Times New Roman",
          ),
        ),
      ),
      body: LoadingOverlay(
        isLoading: _showProgress,
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 4, 28, 104),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: w * 0.4, top: h * 0.01, bottom: h * 0.01),
                child: const Text(
                  'Type of cargo',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: "Times New Roman",
                      color: Colors.white),
                ),
              ),
            ),
            CheckboxListTile(
              title: const Text(
                'Container',
                style: TextStyle(
                  fontFamily: "Times New Roman",
                ),
              ),
              value: containerSelected,
              onChanged: (newValue) {
                setState(() {
                  containerSelected = newValue!;
                });
              },
            ),
            if (containerSelected)
              Column(
                children: [
                  const Text(
                    'Container length',
                    style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  RadioListTile(
                    title: const Text('20 ft'),
                    value: '20 ft',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text('40 ft'),
                    value: '40 ft',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: w * 0.4, left: w * 0.05),
                    child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1)),
                          labelText: 'Number of $_selectedType container',
                          labelStyle: const TextStyle(fontSize: 13)),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (_selectedType.isNotEmpty) {
                          setState(() {
                            _numberContainers = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            CheckboxListTile(
              title: const Text(
                'Loose Cargo',
                style: TextStyle(
                  fontFamily: "Times New Roman",
                ),
              ),
              value: loosecargoSelected,
              onChanged: (newValue) {
                setState(() {
                  loosecargoSelected = newValue!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                'Abnormal Cargo',
                style: TextStyle(
                  fontFamily: "Times New Roman",
                ),
              ),
              value: abnormalSelected,
              onChanged: (newValue) {
                setState(() {
                  abnormalSelected = newValue!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text(
                'Fuel',
                style: TextStyle(
                  fontFamily: "Times New Roman",
                ),
              ),
              value: fuelSelected,
              onChanged: (newValue) {
                setState(() {
                  fuelSelected = newValue!;
                });
              },
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 4, 28, 104),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: w * 0.4, top: h * 0.01, bottom: h * 0.01),
                child: const Text('Destination',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Times New Roman",
                        fontSize: 16,
                        color: Colors.white)),
              ),
            ),
            const ListTile(
              title: Text('Start Point',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Times New Roman",
                      fontSize: 16)),
              subtitle: Text(
                'Dar es Salaam',
                style: TextStyle(
                  fontFamily: "Times New Roman",
                ),
              ),
            ),
            ListTile(
              title: const Text('Destination',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Times New Roman",
                      fontSize: 16)),

              subtitle: TextFormField(
                  controller: destinationctrl,
                  decoration: const InputDecoration(
                    labelText: "Destination",
                    hintMaxLines: 3,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please enter destination");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    destinationctrl.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
            ),
            Column(
              children: [
                Container(
                  width: w,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 4, 28, 104),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: w * 0.2, top: h * 0.01, bottom: h * 0.01),
                    child: const Text(
                      'Choose prefered payment rate \n   (before/after delivery)',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Times New Roman"),
                    ),
                  ),
                ),
                RadioListTile(
                  title: const Text('50/50'),
                  value: '50/50',
                  groupValue: _selectedRate,
                  onChanged: (value) {
                    setState(() {
                      _selectedRate = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('30/70'),
                  value: '30/70',
                  groupValue: _selectedRate,
                  onChanged: (value) {
                    setState(() {
                      _selectedRate = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: h * 0.1,
            ),
            ElevatedButton(
              onPressed: _showSelectedDetailsDialog,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 28, 104)),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectedDetailsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selected Cargo:'),
              if (containerSelected) Text('- Container: $_selectedType'),
              if (loosecargoSelected) const Text('- Loose Cargo'),
              if (abnormalSelected) const Text('- Abnormal Cargo'),
              if (fuelSelected) const Text('- Fuel'),
              Text('Number of containers: $_numberContainers'),
              const SizedBox(height: 16),
              const Text('Selected Destination:'),
              Text('- Destination: $destinationctrl.text'),
              const SizedBox(height: 16),
              const Text('Preferred Payment Rate:'),
              Text('- $_selectedRate'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _uploadSelectedDataToFirestore();
              },
              child: const Text('SUBMIT'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _uploadSelectedDataToFirestore() async {
    setState(() {
      _showProgress = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(user!.uid)
          .collection('myorders')
          .add({
        'transitType': 'LOCAL',
        'username': widget.username,
        'phone': widget.phone,
        'containerSelected': containerSelected,
        'loosecargoSelected': loosecargoSelected,
        'abnormalSelected': abnormalSelected,
        'fuelSelected': fuelSelected,
        'selectedType': _selectedType,
        'status': 'pending',
        'numberContainers': _numberContainers,
        'selectedDestination': destinationctrl.text,
        'selectedDestinationPrice': 'Wait for a moment...',
        'selectedRate': _selectedRate,
        'carDetails': 'Wait for a moment...',
        'payment': 'not paid',
        'passDoc': 'https://bagwan',
        'route': 'DSM',
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
              'Data submitted',
            ),
            backgroundColor: Colors.green),
      );
      setState(() {
        _showProgress = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => const FirestoreDataScreen())));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Error: Please try again',
          ),
          backgroundColor: Colors.red));
    }
  }
}
