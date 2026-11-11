
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'splash_screen_model.dart';
import '/index.dart';
export 'splash_screen_model.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  static String routeName = 'SplashScreen';
  static String routePath = '/splashScreen';

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  late SplashScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashScreenModel());

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.goNamed(BrowseOffersWidget.routeName);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF004D32),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF004D32),
                    Color(0xFF007A4D),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/bingwa_logo.png',
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Kenya's Bundle Marketplace",
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularPercentIndicator(
                      percent: 0.0,
                      radius: 12,
                      lineWidth: 3,
                      animation: true,
                      animateFromLastPercent: true,
                      progressColor: Colors.white,
                      backgroundColor: Colors.white24,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading best offers...',
                      style: GoogleFonts.spaceGrotesk(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
