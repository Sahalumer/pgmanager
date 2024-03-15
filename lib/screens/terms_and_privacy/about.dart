import 'package:flutter/material.dart';
import 'package:pgmanager/components/components.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary.color,
          centerTitle: true,
          foregroundColor: AppColor.white.color,
          toolbarHeight: 65,
          title: const Text('About'),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'House Manager',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'House Manager is a comprehensive application designed to simplify the management of rental houses and lodges for property owners. With House Manager, you can effortlessly oversee multiple properties, keeping track of bedspaces, rent payments, and revenue generation.',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Key Features:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '- Multi-Property Management: ',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Text(
                    'Manage all your rental properties from a single, intuitive interface.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '- Bedspaces Availability: ',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Text(
                    'Instantly check the availability of bedspaces in each property.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '- Rent Payment Tracking: ',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Text(
                    'Keep track of rent payments, ensuring timely collection.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '- Revenue Monitoring: ',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Text(
                    'Monitor the revenue generated from each property, helping you make informed decisions.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Contact:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'For inquiries or support, contact us at hfzsahalumer@gmail.com',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
