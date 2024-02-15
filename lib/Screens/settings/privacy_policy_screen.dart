import 'package:flutter/material.dart';
import 'package:newwwone/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Kprimary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: MixPrimary, // Assuming MixPrimary is a List<Color>
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          title: const Text(
            'Privacy Policy',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 28,
              color: Colors.black54,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: MixPrimary)),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Last updated: [Date]',
                //   style: TextStyle(
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
                // SizedBox(height: 16),
                Text(
                  'At Riz music, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and protect your information when you use the Riz music application (referred to as "the App") developed using Flutter. By using the App, you consent to the practices described in this Privacy Policy.',
                ),
                SizedBox(height: 16),
                Text(
                  'Information We Collect',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. Personal Information: When you create an account on the App, we may collect personal information such as your name, email address, and profile picture. We may also collect information you provide when contacting our support team or participating in surveys or promotions.',
                ),
                SizedBox(height: 8),
                Text(
                  'b. Usage Data: We collect anonymous usage data, including your interactions with the App, such as the features you use, the songs you listen to, and the settings you choose. This information helps us improve the App and provide you with a better user experience.',
                ),
                SizedBox(height: 8),
                Text(
                  'c. Device Information: We may collect information about the device you use to access the App, including the device model, operating system version, unique device identifiers, and mobile network information. This information is used for analytics purposes and to troubleshoot technical issues.',
                ),
                SizedBox(height: 16),
                Text(
                  'Use of Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. We use the information we collect to:',
                ),
                SizedBox(height: 8),
                Text(
                  '- Provide and personalize the App\'s features and content.',
                ),
                SizedBox(height: 8),
                Text(
                  '- Improve and optimize the performance and user experience of the App.',
                ),
                SizedBox(height: 8),
                Text(
                  '- Respond to your inquiries, provide customer support, and address your concerns.',
                ),
                SizedBox(height: 8),
                Text(
                  '- Send you administrative and promotional emails related to the App.',
                ),
                SizedBox(height: 8),
                Text(
                  '- Monitor and analyze trends, usage, and activities in connection with the App.',
                ),
                SizedBox(height: 8),
                Text(
                  '- Detect, investigate, and prevent fraudulent or unauthorized activities.',
                ),
                SizedBox(height: 8),
                Text(
                  'b. We may also aggregate and anonymize the information we collect to generate statistical or analytical data for internal use or sharing with third parties. This data does not personally identify you and is used for purposes such as market research and improving the App.',
                ),
                SizedBox(height: 16),
                Text(
                  'Data Sharing and Disclosure',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. We may share your personal information in the following circumstances:',
                ),
                SizedBox(height: 8),
                Text(
                  '- With service providers who assist us in operating the App and delivering services to you. These service providers are bound by confidentiality obligations and are prohibited from using your information for any other purpose.',
                ),
                SizedBox(height: 8),
                Text(
                  '- In response to a legal request, such as a subpoena, court order, or government investigation, or to comply with applicable laws or regulations.',
                ),
                SizedBox(height: 8),
                Text(
                  '- If we believe it is necessary to protect the rights, property, or safety of Riz music, our users, or others.',
                ),
                SizedBox(height: 8),
                Text(
                  'b. We may also disclose aggregated, non-personally identifiable information to third parties for various purposes, including marketing and advertising.',
                ),
                SizedBox(height: 16),
                Text(
                  'Data Security',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. We implement industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission or electronic storage is 100% secure, and we cannot guarantee absolute security.',
                ),
                SizedBox(height: 8),
                Text(
                  'b. You are responsible for maintaining the confidentiality of your account credentials and ensuring the security of your device. Please notify us immediately if you suspect any unauthorized access or use of your account.',
                ),
                SizedBox(height: 16),
                Text(
                  'Third-Party Links and Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. The App may contain links to third-party websites, services, or advertisements. We are not responsible for the privacy practices or content of these third parties. We encourage you to read the privacy policies of those third parties before interacting with them.',
                ),
                SizedBox(height: 16),
                Text(
                  "Children's Privacy",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. The App is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you believe we have collected information from a child under 13, please contact us, and we will take steps to remove the information.',
                ),
                SizedBox(height: 16),
                Text(
                  'Changes to the Privacy Policy',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'a. We may update this Privacy Policy from time to time. We will notify you of any material changes by posting the updated Privacy Policy within the App or by other means. Your continued use of the App after the effective date of the updated Privacy Policy constitutes your acceptance of the changes.',
                ),
                SizedBox(height: 16),
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'If you have any questions, concerns, or requests regarding this Privacy Policy or the App\'s privacy practices, please contact us at [Contact Information].',
                ),
                SizedBox(height: 16),
                Text(
                  'By using the Riz music App, you signify your understanding and acceptance of this Privacy Policy.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 232, 220),
      ),
    );
  }
}
