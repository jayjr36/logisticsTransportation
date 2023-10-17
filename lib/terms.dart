import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  TermsState createState() => TermsState();
}

class TermsState extends State<Terms> {
  Future<String> _loadPrivacyPolicy() async {
    return await rootBundle.loadString('assets/terms.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
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
