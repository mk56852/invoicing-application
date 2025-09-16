import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  // Email launcher
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': "Contacting you about the app",
        'body': "",
      },
    );

    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch email client');
    }
  }

  // Phone launcher
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri uri = Uri.parse(
      "https://wa.me/98135216",
    );

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp');
    }
  }

  // LinkedIn launcher
  Future<void> _launchLinkedIn(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Contactez-nous:",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () => _launchEmail("melek7967@gmail.com"),
              child: Icon(
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () => _launchPhone("+21698135216"),
              child: Icon(
                Icons.phone,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
