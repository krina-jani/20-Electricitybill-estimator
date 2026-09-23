import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_icons.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: AppIcons.back(size: 20, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppTheme.borderColor, height: 1),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Effective Date: September 21, 2026  •  Last Updated: September 21, 2026',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppTheme.borderColor),
                    const SizedBox(height: 16),

                    const Text(
                      'Emperor Smart Solutions ("we", "us", "our", or "Company") develops and publishes mobile applications, including utility and productivity applications available through Google Play and other supported platforms.\n\nThis Privacy Policy explains how we handle information in our mobile applications. By using PowerCalc, you acknowledge the practices described in this Privacy Policy.',
                      style: TextStyle(fontSize: 13, height: 1.5, color: AppTheme.textSecondary),
                    ),
                    const SizedBox(height: 20),

                    _buildPolicySection('1. Information We Collect',
                        'The information handled by an application depends on the features used. Our basic utility applications, including PowerCalc, generally do not require users to create an account, provide their name, email address, phone number, or other personal information.'),

                    _buildPolicySection('2. Information Processed Locally',
                        'PowerCalc performs its primary functions directly on the user\'s device. All calculations, electricity rate inputs, unit selections, standing charges, and taxes are processed locally without sending data to external servers.'),

                    _buildPolicySection('3. Advertising & Third-Party Services',
                        'Some of our applications may display advertisements provided by third-party advertising services, such as Google AdMob. Third-party advertising providers may collect device information, advertising identifiers, or diagnostics in accordance with their respective privacy policies.'),

                    _buildPolicySection('4. Analytics & Performance',
                        'We may use performance monitoring or crash reporting tools to detect technical issues and improve application stability. Where applicable, data collection complies with Google Play Data Safety specifications.'),

                    _buildPolicySection('5. How We Use Information',
                        'Information handled locally is used solely to calculate bill estimates and operate application features. We do not sell users\' personal information.'),

                    _buildPolicySection('6. Data Security',
                        'We take reasonable security measures appropriate to protect information. However, no method of electronic storage or transmission can be guaranteed to be 100% secure.'),

                    _buildPolicySection('7. Data Retention & Deletion',
                        'Because PowerCalc processes data locally on your device, we do not retain your calculation entries on our servers.'),

                    _buildPolicySection('8. Children\'s Privacy',
                        'Our applications are not intended to knowingly collect personal information from children in violation of applicable laws.'),

                    _buildPolicySection('9. Permissions',
                        'PowerCalc requests no unnecessary device permissions. Any permission requested in the future will be strictly required for functionality.'),

                    _buildPolicySection('10. External Links',
                        'Our application or About page contains links to external social profiles (Instagram, LinkedIn). We are not responsible for the privacy practices of external websites.'),

                    _buildPolicySection('11. Changes to This Privacy Policy',
                        'We may update this Privacy Policy periodically. Changes will be reflected with an updated "Last Updated" date.'),

                    _buildPolicySection('12. Contact Us',
                        'If you have questions regarding this Privacy Policy:\n\nEmperor Smart Solutions\nPhone: +91 63543 51080\nInstagram: https://www.instagram.com/emperorsmartsolutions\nLinkedIn: https://www.linkedin.com/company/emperor-smart-solutions/'),

                    const SizedBox(height: 16),
                    const Divider(height: 1, color: AppTheme.borderColor),
                    const SizedBox(height: 16),
                    const Center(
                      child: Text(
                        '© 2026 Emperor Smart Solutions. All rights reserved.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
