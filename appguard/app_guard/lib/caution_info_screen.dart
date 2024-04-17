import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MaterialApp(
    home: CautionInfoScreen(),
  ));
}

class CautionInfoScreen extends StatelessWidget {
  final List<String> cautionTexts = [
    // Text for each page of the slider
    "Page 1: Security Threats\n\nProtect your device and personal information by following these security tips:\n\n\n• Download Apps Only from Trusted Sources like  Google Play or Apple App Store.\n \n • Be Wary of Unknown Links from unknown sources, especially in messages or emails.\n\n• Use Secure Internet Connections; Avoid connectivity to open public wifi\n\n• Ensure websites use 'https' for secure browsing.\n\n• Keep Softwares Updated.\n\n• Review App Permissions. Scrutinize the permissions requested by apps during installation. Deny unnecessary permissions that seem unrelated to the app's function.",
    "Page 2: More Security Tips\n\nAdditional measures to safeguard your device and data:\n\n\n• Install Reputable Security Apps:\n  - Use trusted antivirus apps for malware protection.\n\n• Use Strong Passwords:\n  - Create complex passwords; consider a password manager.\n\n• Enable Two-Factor Authentication:\n  - Activate 2FA for added account security.\n\n• Check App Permissions:\n  - Regularly review and manage app permissions.\n\n• Stay Informed:\n  - Keep up-to-date on security threats and best practices.",
    "Page 3: Battery-Saving Tips\n\nOptimize your device's battery life with these techniques:\n\n\n• Adjust Screen Brightness; Lower screen brightness or enable auto-brightness to conserve battery.\n\n• Close apps running in the background to save energy.\n\n• Keep apps up-to-date for better battery optimization.\n\n• Use location services selectively for apps; turn off when not needed.\n\n• Use Battery-Saver Mode.\n\n• Keep your phone in moderate temperatures to preserve battery performance.\n\n• Optimize sync settings for apps like email to conserve battery.\n\n• Close Unused Apps.\n\n• Monitor Battery Usage.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caution Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange[800], // Orange[900] appbar color
      ),
      body: Container(
        color: Colors.blueGrey[900], // BlueGrey[900] background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: cautionTexts.map((text) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors
                            .blueGrey[700], // BlueGrey[700] container color
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.orange,
                        ), // Orange[900] border color
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 600,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
