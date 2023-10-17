import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  PrivacyState createState() => PrivacyState();
}

class PrivacyState extends State<Privacy> {
  Future<String> _loadPrivacyPolicy() async {
    return await rootBundle.loadString('assets/privacy.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: FutureBuilder<String>(
        future: _loadPrivacyPolicy(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final privacyPolicyText = snapshot.data ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(privacyPolicyText),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
