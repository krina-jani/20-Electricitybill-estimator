import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'privacy_policy_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/app_icons.dart';

class AboutPrivacyScreen extends StatelessWidget {
  const AboutPrivacyScreen({super.key});

  static const String instagramUrl = 'https://www.instagram.com/emperorsmartsolutions?stkn=eng4aTNpcWZqbWE=';
  static const String linkedInUrl = 'https://www.linkedin.com/company/emperor-smart-solutions/';
  static const String phoneNumber = '+916354351080';
  static const String formattedPhone = '+91 63543 51080';

  Future<void> _launchURL(BuildContext context, String urlString) async {
    try {
      final Uri uri = Uri.parse(urlString);
      if (kIsWeb) {
        bool launched = await launchUrl(uri, webOnlyWindowName: '_blank');
        if (!launched) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        }
        return;
      }

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      try {
        final Uri uri = Uri.parse(urlString);
        await launchUrl(uri);
      } catch (_) {}
    }
  }

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
          'About & Privacy',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Information Card
                  _buildSectionHeader('APP INFORMATION'),
                  const SizedBox(height: 8),
                  _buildCard([
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/logo.png',
                            width: 54,
                            height: 54,
                            errorBuilder: (context, error, stackTrace) => AppIcons.logo(size: 54),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'PowerCalc',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Electricity Cost Calculator & Estimator',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Version 1.0.0',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(height: 1, color: AppTheme.borderColor),
                    const SizedBox(height: 14),
                    const Text(
                      'PowerCalc is an offline electricity bill estimator designed to calculate energy costs from consumption (kWh), electricity rates, standing charges, network charges, and taxes across daily, monthly, and annual periods.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Legal & Privacy Policy
                  _buildSectionHeader('LEGAL & PRIVACY'),
                  const SizedBox(height: 8),
                  _buildCard([
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AppIcons.privacy(size: 22, color: AppTheme.primaryAccent),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Read our full data protection policy',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppIcons.chevronRight(size: 18, color: AppTheme.textSecondary),
                          ],
                        ),
                      ),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Connect With Us
                  _buildSectionHeader('CONNECT WITH US'),
                  const SizedBox(height: 8),
                  _buildCard([
                    // Instagram Tile
                    _buildLinkTile(
                      iconWidget: AppIcons.instagram(size: 22, color: const Color(0xFFE1306C)),
                      iconBg: const Color(0xFFFDF2F8),
                      title: 'Instagram',
                      subtitle: 'Follow us on Instagram',
                      onTap: () => _launchURL(context, instagramUrl),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Divider(height: 1, color: AppTheme.borderColor),
                    ),

                    // LinkedIn Tile
                    _buildLinkTile(
                      iconWidget: AppIcons.linkedIn(size: 22, color: const Color(0xFF0A66C2)),
                      iconBg: const Color(0xFFF0F9FF),
                      title: 'LinkedIn',
                      subtitle: 'Connect on LinkedIn',
                      onTap: () => _launchURL(context, linkedInUrl),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Divider(height: 1, color: AppTheme.borderColor),
                    ),

                    // Facebook Tile
                    _buildLinkTile(
                      iconWidget: AppIcons.facebook(size: 22, color: const Color(0xFF1877F2)),
                      iconBg: const Color(0xFFEEF2FF),
                      title: 'Facebook',
                      subtitle: 'Follow us on Facebook',
                      onTap: () => _launchURL(context, facebookUrl),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Divider(height: 1, color: AppTheme.borderColor),
                    ),

                    // Contact Us Phone Tile
                    _buildLinkTile(
                      iconWidget: AppIcons.phone(size: 22, color: AppTheme.accentGreen),
                      iconBg: const Color(0xFFECFDF5),
                      title: 'Contact Us',
                      subtitle: formattedPhone,
                      onTap: () => _launchURL(context, 'tel:$phoneNumber'),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Developer Section
                  _buildSectionHeader('DEVELOPER'),
                  const SizedBox(height: 8),
                  _buildCard([
                    const Text(
                      'Emperor Smart Solutions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Emperor Smart Solutions develops software, mobile applications, digital products, and utility applications.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      '© 2026 Emperor Smart Solutions. All rights reserved.',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppTheme.textSecondary,
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
        children: children,
      ),
    );
  }

  Widget _buildLinkTile({
    required Widget iconWidget,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: iconWidget,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            AppIcons.chevronRight(size: 18, color: AppTheme.textSecondary),
          ],
        ),
      ),
    );
  }
}
