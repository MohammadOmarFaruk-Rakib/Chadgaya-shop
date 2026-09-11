import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0A1A), Color(0xFF1A1A3E)],
        ),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 150,
            runSpacing: 100,
            children: [
              // Brand
              SizedBox(
                width: 260,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.fastfood_rounded,
                            color: Color(0xFF6C63FF),
                            size: 34,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chadgaya',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Shop',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF6C63FF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Your Premier Shopping Destination',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // Social Links
              SizedBox(
                width: 190,
                child: Column(
                  children: [
                    Text(
                      '📱 Follow Us',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._buildSocialLinks(),
                  ],
                ),
              ),

              // Contact
              SizedBox(
                width: 240,
                child: Column(
                  children: [
                    Text(
                      '📞 Contact Us',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._buildContactLinks(),
                  ],
                ),
              ),

              // Quick Links
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    Text(
                      '🔗 Quick Links',
                      style: GoogleFonts.montserrat(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._buildQuickLinks(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(height: 1, color: Colors.grey.withValues(alpha: 0.15)),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                '© ${DateTime.now().year} Chadgaya Shop. All rights reserved.',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Designed by Mohammad Omar Faruk',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: const Color(0xFF6C63FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSocialLinks() {
    final socials = [
      {'icon': Icons.facebook_rounded, 'label': 'Facebook', 'color': 0xFF1877F2, 'url': 'https://facebook.com'},
      {'icon': Icons.camera_alt_rounded, 'label': 'Instagram', 'color': 0xFFE4405F, 'url': 'https://instagram.com'},
      {'icon': Icons.play_circle_rounded, 'label': 'YouTube', 'color': 0xFFFF0000, 'url': 'https://youtube.com'},
      {'icon': Icons.chat_rounded, 'label': 'WhatsApp', 'color': 0xFF25D366, 'url': 'https://wa.me/1234567890'},
      {'icon': Icons.link_rounded, 'label': 'LinkedIn', 'color': 0xFF0A66C2, 'url': 'https://linkedin.com'},
    ];

    return socials.map((social) {
      final color = Color(social['color'] as int);
      return GestureDetector(
        onTap: () => _launchURL(social['url'] as String),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(social['icon'] as IconData, color: color, size: 18),
              const SizedBox(width: 12),
              Text(
                social['label'] as String,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildContactLinks() {
    final contacts = [
      {'icon': Icons.email_outlined, 'label': 'support@chadgayashop.com', 'action': 'email'},
      {'icon': Icons.phone_outlined, 'label': '+1 234 567 8900', 'action': 'phone'},
      {'icon': Icons.location_on_outlined, 'label': '123 Food Street, Dhaka', 'action': 'map'},
    ];

    return contacts.map((contact) {
      return GestureDetector(
        onTap: () {
          switch (contact['action']) {
            case 'email':
              _launchEmail(contact['label'] as String);
              break;
            case 'phone':
              _launchPhone(contact['label'] as String);
              break;
            case 'map':
              _launchMap(contact['label'] as String);
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                contact['icon'] as IconData,
                color: const Color(0xFF6C63FF),
                size: 18,
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  contact['label'] as String,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildQuickLinks() {
    final links = [
      {'label': 'About Us', 'route': '/about'},
      {'label': 'Privacy Policy', 'route': '/privacy'},
      {'label': 'Terms & Conditions', 'route': '/terms'},
      {'label': 'Refund Policy', 'route': '/refund'},
      {'label': 'FAQ', 'route': '/faq'},
    ];

    return links.map((link) {
      return GestureDetector(
        onTap: () => Get.toNamed(link['route'] as String),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            link['label'] as String,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      );
    }).toList();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  Future<void> _launchMap(String address) async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
