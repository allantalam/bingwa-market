
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferDetailsWidget extends StatefulWidget {
  // Selected offer information
  static String selectedTitle = 'Power Hour Bundle';
  static String selectedCategory = 'Bundles';
  static String selectedDetail = '500MB Data';
  static String selectedPrice = '20';
  static String selectedValidity = '1 Hour';
  static String selectedSeller = 'Verified Bingwa';
  static String selectedLastVerified = 'Recently verified';

  const OfferDetailsWidget({super.key});

  static String routeName = 'OfferDetails';
  static String routePath = '/offerDetails';

  @override
  State<OfferDetailsWidget> createState() =>
      _OfferDetailsWidgetState();
}

class _OfferDetailsWidgetState extends State<OfferDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    final title = OfferDetailsWidget.selectedTitle;
    final category = OfferDetailsWidget.selectedCategory;
    final detail = OfferDetailsWidget.selectedDetail;
    final price = OfferDetailsWidget.selectedPrice;
    final validity = OfferDetailsWidget.selectedValidity;
    final seller = OfferDetailsWidget.selectedSeller;
    final lastVerified = OfferDetailsWidget.selectedLastVerified;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      body: Column(
        children: [
          // HEADER
          Container(
            color: theme.secondaryBackground,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 8,
                  buttonSize: 40,
                  fillColor: Colors.transparent,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: theme.primaryText,
                    size: 24,
                  ),
                  onPressed: () {
                    context.goNamed(BrowseOffersWidget.routeName);
                  },
                ),
                Text(
                  'Offer Details',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryText,
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
          ),

          Divider(height: 1, color: theme.alternate),

          // DETAILS
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // MAIN OFFER CARD
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.alternate),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryText,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: theme.primary,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Verified',
                                    style: TextStyle(
                                      color: theme.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          category,
                          style: TextStyle(
                            color: theme.secondaryText,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 20),
                        Divider(color: theme.alternate),
                        const SizedBox(height: 16),

                        Text(
                          'Price',
                          style: TextStyle(
                            color: theme.secondaryText,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'KSh $price',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: theme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // SPECIFICATIONS
                  Text(
                    'Specifications',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.alternate),
                    ),
                    child: Column(
                      children: [
                        _detailRow(
                          context,
                          Icons.speed_rounded,
                          'Allowance',
                          detail,
                        ),
                        const SizedBox(height: 18),
                        _detailRow(
                          context,
                          Icons.update_rounded,
                          'Validity',
                          validity,
                        ),
                        const SizedBox(height: 18),
                        _detailRow(
                          context,
                          Icons.person_rounded,
                          'Bingwa',
                          seller,
                        ),
                        const SizedBox(height: 18),
                        _detailRow(
                          context,
                          Icons.verified_user_rounded,
                          'Verification',
                          lastVerified,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // DESCRIPTION
                  Text(
                    'Description',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '$detail offer with a validity period of $validity. '
                    'Check the offer specifications before purchasing. '
                    'Fulfilment is subject to confirmation by the seller.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: theme.secondaryText,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // TERMS
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.primaryText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '• Confirm the offer details before payment.\n'
                          '• Fulfilment is subject to seller confirmation.\n'
                          '• Keep your payment confirmation for reference.',
                          style: TextStyle(
                            color: theme.secondaryText,
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // REPORT OFFER
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        context.goNamed(ReportOfferWidget.routeName);
                      },
                      icon: Icon(
                        Icons.flag_rounded,
                        color: theme.secondaryText,
                      ),
                      label: Text(
                        'Report this Offer',
                        style: TextStyle(color: theme.secondaryText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BUY BUTTON
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.secondaryBackground,
              border: Border(
                top: BorderSide(color: theme.alternate),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.goNamed(
                    MPesaPurchaseScreenWidget.routeName,
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout_rounded),
                label: const Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primary,
                  foregroundColor: theme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    final theme = FlutterFlowTheme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.primary, size: 21),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: theme.secondaryText,
              fontSize: 13,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: theme.primaryText,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
