import 'package:flutter/material.dart';
import '../utilities/constants.dart';

/// Displays information about the bookstore application.
///
/// Contains the brand introduction, contact information,
/// and business working hours.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // Application header for the about section.
      appBar: AppBar(
        backgroundColor: kSurfaceColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kPrimaryColor),
        title: const Text(
          'درباره ما',
          style: kTitleSmallTextStyle,
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // About page banner image with fallback placeholder.
            SizedBox(
              height: 220,
              child: Image.asset(
                'assets/images/about.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: kSurfaceLightColor,
                  child: const Icon(
                    Icons.store,
                    size: 72,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(kPaddingXLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Store introduction section.
                  const Text(
                    'کتابکده',
                    style: kAboutTitleTextStyle,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'کتابکده یک فروشگاه آنلاین کتاب است که با هدف دسترسی آسان علاقه مندان '
                        'به کتاب های فارسی و ترجمه راه‌اندازی شده است. ما تلاش میکنیم بهترین '
                        'عناوین را با قیمت مناسب و ارسال سریع در اختیار شما قرار دهیم.',
                    style: kAboutDescriptionTextStyle,
                  ),

                  const SizedBox(height: 24),

                  // Contact information card.
                  Card(
                    color: kSurfaceColor,
                    elevation: 4,
                    shadowColor: kPrimaryColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      side: BorderSide(
                        color: kPrimaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(kPaddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            'راه های ارتباطی',
                            style: kAboutHeadingTextStyle,
                          ),

                          const SizedBox(height: 8),

                          // Contact details list.
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.phone, color: kPrimaryColor),
                            title: const Text(
                              '۰۲۱-۱۲۳۴۵۶۷۸',
                              style: TextStyle(color: kTextColor),
                            ),
                          ),

                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.email_outlined, color: kPrimaryColor),
                            title: const Text(
                              'info@ketabkade.ir',
                              style: TextStyle(color: kTextColor),
                            ),
                          ),

                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.location_on_outlined, color: kPrimaryColor),
                            title: const Text(
                              'خرم‌آباد، خیابان انقلاب، پلاک ۱۲',
                              style: TextStyle(color: kTextColor),
                            ),
                          ),

                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.telegram, color: kPrimaryColor),
                            title: const Text(
                              '@ketabkade_ir',
                              style: TextStyle(color: kTextColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Business hours information card.
                  Card(
                    color: kSurfaceColor,
                    elevation: 4,
                    shadowColor: kPrimaryColor.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadiusMedium),
                      side: BorderSide(
                        color: kPrimaryColor.withOpacity(0.2),
                        width: 1,
                      ),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(kPaddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_outlined,
                                color: kPrimaryColor,
                                size: 20,
                              ),

                              const SizedBox(width: 10),

                              const Text(
                                'ساعات کاری',
                                style: kAboutHeadingTextStyle,
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'شنبه تا چهارشنبه: ۹:۰۰ تا ۱۸:۰۰\n'
                                'پنجشنبه: ۹:۰۰ تا ۱۴:۰۰\n'
                                'جمعه: تعطیل',
                            style: kAboutSubtitleTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}