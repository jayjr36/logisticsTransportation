// ignore_for_file: file_names

import 'package:bagwan/models/banner.dart';
import 'package:bagwan/models/models.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class CargoDetailsScreen extends StatefulWidget {
  final Models models;
  final String formattedDateTime;
  final String selectedDestination;
  final String selectedDestinationPrice;
  final String selectedRate;
  final String carDetails;
  final String documentId;
  final List<String> route;
  final String transitType;
 const CargoDetailsScreen({
    super.key,
    required this.formattedDateTime,
    required this.selectedDestination,
    required this.selectedDestinationPrice,
    required this.selectedRate,
    required this.carDetails,
    required this.models,
    required this.documentId,
    required this.route, 
    required this.transitType,
  });

  @override
  State<CargoDetailsScreen> createState() => _CargoDetailsScreenState();
}

class _CargoDetailsScreenState extends State<CargoDetailsScreen> {
bool showProgress = false;  

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargo Details'),
      ),
      body: LoadingOverlay(
        isLoading: showProgress,
        child: Builder(builder: (context) {
          return Card(
            elevation: 5,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text(widget.transitType, style: const TextStyle(fontFamily: "Times New Roman",)),
                Text('Date: ${widget.formattedDateTime}', style: const TextStyle(fontFamily: "Times New Roman",)),
                Text('Destination: ${widget.selectedDestination}', style: const TextStyle(fontFamily: "Times New Roman",)),
                Text('Price: Tshs ${widget.selectedDestinationPrice}', style: const TextStyle(fontFamily: "Times New Roman",)),
                Text('Payment rate: ${widget.selectedRate}', style: const TextStyle(fontFamily: "Times New Roman",)),
                Text('Details: ${widget.carDetails}', style: const TextStyle(fontFamily: "Times New Roman",)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showProgress = true;
                        });
                        Future.delayed(const Duration(seconds: 2));
                        widget.models.uploadDocument(context, widget.documentId);
                        setState(() {
                          showProgress = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 28, 104),
                      ),
                      child: const Text(
                        "UPLOAD RELEASE ORDER",
                        style: TextStyle(color: Colors.white, fontFamily: "Times New Roman",),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.15),
                  child: TextButton(
                      onPressed: () {
                        Scaffold.of(context)
                            .showBottomSheet((context) => const BannerWidget());
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 28, 104),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.07),
                        child: const Text(
                          'Get Payment details',
                          style: TextStyle(color: Colors.white, fontFamily: "Times New Roman",),
                        ),
                      )),
                ),
                Text('Route: ${widget.route.isNotEmpty ? widget.route[0] : "N/A"}', style: const TextStyle(fontFamily: "Times New Roman",)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
