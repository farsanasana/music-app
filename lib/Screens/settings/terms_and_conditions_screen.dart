import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        title: const Text(
          'Melofinder',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.black,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Please read these Terms and Conditions ("Terms") carefully before using the Riz music application ("the App") provided by Riz music ("we," "us," or "our"). These Terms govern your access to and use of the App. By using the App, you agree to be bound by these Terms. If you do not agree to these Terms, please refrain from using the App.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Use of the App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. The Riz music App is intended for personal, non-commercial use only. You may not use the App for any unauthorized or illegal purposes.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'b. You must be at least 13 years old to use the App. If you are under 18 years old, you must obtain parental consent before using the App.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'c. You are responsible for maintaining the confidentiality of your account information and ensuring that it is accurate and up-to-date.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Intellectual Property',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. The App, including all its content, features, and functionality, is owned by Riz music and is protected by intellectual property laws. You may not copy, modify, distribute, transmit, display, perform, or create derivative works from any part of the App without our prior written consent.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'b. The trademarks, logos, and service marks displayed within the App are the property of Riz music or third parties. You are prohibited from using any of these marks without our prior written permission or the permission of the respective owners.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'User-Generated Content',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. The App may allow you to upload, post, or submit user-generated content, such as comments or reviews. By submitting such content, you grant Riz music a worldwide, royalty-free, non-exclusive, perpetual, irrevocable, and sublicensable right to use, reproduce, modify, adapt, publish, translate, distribute, and display the content in any media.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'b. You are solely responsible for the content you submit and must ensure that it does not violate any third-party rights, including copyrights, trademarks, or privacy rights. We reserve the right to remove any content that we consider inappropriate or in violation of these Terms.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Privacy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. We respect your privacy and handle your personal information in accordance with our Privacy Policy. By using the App, you consent to the collection, use, and disclosure of your information as described in the Privacy Policy.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Limitation of Liability',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. The App is provided on an "as is" and "as available" basis without any warranties, expressed or implied. We do not guarantee that the App will be error-free, uninterrupted, or secure.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'b. In no event shall Riz music, its directors, officers, employees, or agents be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of the App or the inability to use the App.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Modifications to the App and Terms',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. We reserve the right to modify or discontinue the App at any time without prior notice. We may also revise these Terms from time to time. The updated Terms will be effective upon posting on the App.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'b. It is your responsibility to review these Terms periodically to stay informed of any changes. By continuing to use the App after the revised Terms have been posted, you agree to be bound by the updated Terms.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Governing Law and Jurisdiction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. These Terms shall be governed by and construed in accordance with the laws of [Your Jurisdiction]. Any disputes arising out of or in connection with these Terms shall be subject to the exclusive jurisdiction of the courts of [Your Jurisdiction].',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Entire Agreement',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'a. These Terms constitute the entire agreement between you and Riz music regarding the use of the App and supersede any prior or contemporaneous understandings.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions or concerns about these Terms, please contact us at [Contact Information].',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 232, 220),
    );
  }
}
