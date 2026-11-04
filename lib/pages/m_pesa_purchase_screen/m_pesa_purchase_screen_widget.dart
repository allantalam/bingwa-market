
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MPesaPurchaseScreenWidget extends StatefulWidget {
  const MPesaPurchaseScreenWidget({super.key});

  static String routeName = 'MPesaPurchaseScreen';
  static String routePath = '/mPesaPurchaseScreen';

  @override
  State<MPesaPurchaseScreenWidget> createState() =>
      _MPesaPurchaseScreenWidgetState();
}

class _MPesaPurchaseScreenWidgetState
    extends State<MPesaPurchaseScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneController =
      TextEditingController();

  String? _phoneError;

  // Selected offer information
  String get offerTitle => OfferDetailsWidget.selectedTitle;
  String get offerDetail => OfferDetailsWidget.selectedDetail;
  String get offerValidity => OfferDetailsWidget.selectedValidity;
  String get offerPrice => OfferDetailsWidget.selectedPrice;

  // Convert price into a number
  double get price {
    return double.tryParse(
          offerPrice.replaceAll(',', '').replaceAll('KSh', '').trim(),
        ) ??
        0;
  }

  String get formattedPrice {
    return price.toStringAsFixed(2);
  }

  // Normalize Kenyan phone numbers
  String _normalizePhone(String phone) {
    String number = phone.replaceAll(RegExp(r'[\s\-()]'), '');

    if (number.startsWith('+254')) {
      number = '0${number.substring(4)}';
    } else if (number.startsWith('254')) {
      number = '0${number.substring(3)}';
    }

    return number;
  }

  bool _validatePhone() {
    final phone = _normalizePhone(_phoneController.text.trim());

    final valid = RegExp(r'^(07|01)\d{8}$').hasMatch(phone);

    setState(() {
      _phoneError = valid
          ? null
          : 'Enter a valid Kenyan number, e.g. 0712345678';
    });

    return valid;
  }

  void _continueToPayment() {
    FocusScope.of(context).unfocus();

    if (!_validatePhone()) return;

    final phone = _normalizePhone(_phoneController.text.trim());

    // Payment integration will be connected through Daraja API.
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Purchase details confirmed'),
          content: Text(
            'Offer: $offerTitle\n'
            'Amount: KSh $formattedPrice\n'
            'M-Pesa number: $phone\n\n'
            'Your details are valid. M-Pesa payment processing '
            'will be activated after Daraja API integration.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              color: theme.secondaryBackground,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.goNamed(OfferDetailsWidget.routeName);
                    },
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Complete Purchase',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryText,
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: theme.alternate),

            // MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // OFFER SUMMARY
                    Text(
                      'OFFER SUMMARY',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryText,
                        letterSpacing: 1,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offerTitle,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            offerDetail,
                            style: TextStyle(
                              color: theme.secondaryText,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Validity: $offerValidity',
                            style: TextStyle(
                              color: theme.secondaryText,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Divider(color: theme.alternate),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Offer price',
                                style: TextStyle(
                                  color: theme.secondaryText,
                                ),
                              ),
                              Text(
                                'KSh $formattedPrice',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // PAYMENT METHOD
                    Text(
                      'PAYMENT METHOD',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryText,
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: theme.secondaryBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.alternate),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(
                                    alpha: 0.10,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.green,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'M-Pesa STK Push',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: theme.primaryText,
                                      ),
                                    ),
                                    Text(
                                      'Safaricom mobile money',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: theme.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          Text(
                            'M-Pesa Phone Number',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: theme.primaryText,
                            ),
                          ),

                          const SizedBox(height: 8),

                          TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 13,
                            onChanged: (value) {
                              if (_phoneError != null) {
                                setState(() {
                                  _phoneError = null;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: '0712345678',
                              counterText: '',
                              prefixIcon: const Icon(
                                Icons.phone_android_rounded,
                              ),
                              errorText: _phoneError,
                              filled: true,
                              fillColor: theme.primaryBackground,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: theme.alternate,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            'Enter a Safaricom number that will receive '
                            'the M-Pesa payment request.',
                            style: TextStyle(
                              color: theme.secondaryText,
                              fontSize: 12,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: theme.primary.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: theme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'You will receive an M-Pesa prompt '
                                    'on your phone. Enter your M-Pesa PIN '
                                    'only on your phone to authorize payment.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.5,
                                      color: theme.primaryText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // PAYMENT BREAKDOWN
                    Text(
                      'PAYMENT BREAKDOWN',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.secondaryText,
                        letterSpacing: 1,
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
                          _amountRow(
                            'Subtotal',
                            'KSh $formattedPrice',
                            theme,
                          ),
                          const SizedBox(height: 14),
                          _amountRow(
                            'Service Fee',
                            'KSh 0.00',
                            theme,
                          ),
                          const SizedBox(height: 14),
                          Divider(color: theme.alternate),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: theme.primaryText,
                                ),
                              ),
                              Text(
                                'KSh $formattedPrice',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: theme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // CONTINUE BUTTON
                    SizedBox(
                      height: 54,
                      child: ElevatedButton.icon(
                        onPressed: _continueToPayment,
                        icon: const Icon(
                          Icons.arrow_forward_rounded,
                        ),
                        label: const Text('Continue to Payment'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primary,
                          foregroundColor: theme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: () {
                        context.goNamed(BrowseOffersWidget.routeName);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        foregroundColor: theme.primaryText,
                        side: BorderSide(color: theme.alternate),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel Transaction'),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline_rounded,
                          size: 15,
                          color: theme.secondaryText,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Secure payment via M-Pesa',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.secondaryText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amountRow(
    String label,
    String amount,
    FlutterFlowTheme theme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: theme.secondaryText,
            fontSize: 14,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: theme.primaryText,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
