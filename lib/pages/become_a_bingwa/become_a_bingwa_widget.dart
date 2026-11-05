
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

class BecomeABingwaWidget extends StatefulWidget {
  const BecomeABingwaWidget({super.key});

  static String routeName = 'BecomeABingwa';
  static String routePath = '/becomeABingwa';

  @override
  State<BecomeABingwaWidget> createState() => _BecomeABingwaWidgetState();
}

class _BecomeABingwaWidgetState extends State<BecomeABingwaWidget> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _businessInfoController = TextEditingController();
  final _tillController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSubmitting = false;
  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _businessInfoController.dispose();
    _tillController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String _normalisePhone(String phone) {
    String value = phone.replaceAll(RegExp(r'[\s-]'), '');

    if (value.startsWith('+254')) {
      value = value.substring(1);
    } else if (value.startsWith('0')) {
      value = '254${value.substring(1)}';
    }

    return value;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your phone number';
    }

    final phone = value.replaceAll(RegExp(r'[\s-]'), '');

    if (!RegExp(r'^(?:07|01)\d{8}$|^(?:\+254|254)[17]\d{8}$')
        .hasMatch(phone)) {
      return 'Enter a valid Kenyan mobile number';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email address';
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
        .hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? _validateTill(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your M-Pesa Till number';
    }

    if (!RegExp(r'^\d{6,7}$').hasMatch(value.trim())) {
      return 'Till number must contain 6–7 digits';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Create a password';
    }

    if (value.length < 8) {
      return 'Password must have at least 8 characters';
    }

    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  void _showMessage(String message, {bool isError = true}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        ),
      );
  }

  Future<void> _submitApplication() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    UserCredential? credential;

    try {
      final email = _emailController.text.trim().toLowerCase();

      // Create the seller's Firebase Authentication account.
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: _passwordController.text,
      );

      final user = credential.user;

      if (user == null) {
        throw Exception('Firebase did not return a user account.');
      }

      // Save the application using the Firebase UID as document ID.
      await FirebaseFirestore.instance
          .collection('sellers')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'fullName': _fullNameController.text.trim(),
        'email': email,
        'phoneNumber': _normalisePhone(_phoneController.text.trim()),
        'businessName': _businessNameController.text.trim(),
        'businessInformation': _businessInfoController.text.trim(),
        'tillNumber': _tillController.text.trim(),
        'approvalStatus': 'pending',
        'accountRole': 'seller',
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => AlertDialog(
          icon: const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
            size: 48,
          ),
          title: const Text('Application submitted'),
          content: const Text(
            'Your Bingwa account has been created successfully. '
            'Your application is now pending admin review. '
            'You will be able to access seller features after approval.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Continue browsing'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      context.goNamed(BrowseOffersWidget.routeName);
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account already exists with this email address.';
          break;
        case 'weak-password':
          message = 'Please choose a stronger password.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'network-request-failed':
          message = 'Network error. Check your internet connection.';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Please try again later.';
          break;
        default:
          message = e.message ?? 'Could not create your account.';
      }

      _showMessage(message);
    } on FirebaseException catch (e) {
      if (credential?.user != null) {
        _showMessage(
          'Your login account was created, but your application could not '
          'be saved. Do not register again. Please contact support. '
          'Error: ${e.code}',
        );
      } else {
        _showMessage('Could not submit your application: ${e.message}');
      }
    } catch (e) {
      _showMessage('Something went wrong. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Widget _buildField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final theme = FlutterFlowTheme.of(context);

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      enabled: !_isSubmitting,
      style: GoogleFonts.inter(
        color: theme.primaryText,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: theme.secondaryText),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: theme.secondaryBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.alternate),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.alternate),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }

  Widget _featureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = FlutterFlowTheme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: theme.primary, size: 23),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: theme.primaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  height: 1.5,
                  color: theme.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.primaryBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
                  decoration: BoxDecoration(
                    color: theme.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Become a Bingwa',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: theme.onPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Join Kenya\'s leading marketplace for mobile bundles '
                        'and earn by helping customers find the best deals.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          height: 1.5,
                          color: theme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _featureItem(
                        icon: Icons.store_rounded,
                        title: 'List Your Offers',
                        description:
                            'Submit data, minutes, and SMS bundles for '
                            'administrative review and publication.',
                      ),
                      const SizedBox(height: 24),
                      _featureItem(
                        icon: Icons.verified_user_rounded,
                        title: 'Build Trust',
                        description:
                            'Get your offers verified by admins to increase '
                            'visibility and customer confidence.',
                      ),
                      const SizedBox(height: 24),
                      _featureItem(
                        icon: Icons.payments_rounded,
                        title: 'Direct Payments',
                        description:
                            'Receive payments directly to your M-Pesa Till '
                            'number from verified customers.',
                      ),
                    ],
                  ),
                ),

                Divider(
                  height: 1,
                  thickness: 1,
                  indent: 24,
                  endIndent: 24,
                  color: theme.alternate,
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Bingwa Application',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your seller account and provide your '
                          'business details for review.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: theme.secondaryText,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 20),

                        _buildField(
                          label: 'Full Name',
                          hint: 'Enter your legal name',
                          controller: _fullNameController,
                          icon: Icons.person_outline_rounded,
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'Email Address',
                          hint: 'email@example.com',
                          controller: _emailController,
                          icon: Icons.mail_outline_rounded,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'Phone Number',
                          hint: '07XXXXXXXX or +2547XXXXXXXX',
                          controller: _phoneController,
                          icon: Icons.phone_android_rounded,
                          keyboardType: TextInputType.phone,
                          validator: _validatePhone,
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'Business or Trading Name',
                          hint: 'e.g. Juma Communications',
                          controller: _businessNameController,
                          icon: Icons.store_outlined,
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'Business Information',
                          hint: 'Briefly describe your services',
                          controller: _businessInfoController,
                          icon: Icons.description_outlined,
                          maxLines: 3,
                          validator: _requiredValidator,
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'M-Pesa Till Number',
                          hint: 'Enter your 6–7 digit Till number',
                          controller: _tillController,
                          icon: Icons.payments_outlined,
                          keyboardType: TextInputType.number,
                          validator: _validateTill,
                        ),

                        const SizedBox(height: 24),
                        Text(
                          'Account Security',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: theme.primaryText,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'Password',
                          hint: 'At least 8 characters',
                          controller: _passwordController,
                          icon: Icons.lock_outline_rounded,
                          obscureText: _hidePassword,
                          validator: _validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() => _hidePassword = !_hidePassword);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildField(
                          label: 'Confirm Password',
                          hint: 'Enter your password again',
                          controller: _confirmPasswordController,
                          icon: Icons.lock_outline_rounded,
                          obscureText: _hideConfirmPassword,
                          validator: _validateConfirmPassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _hideConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hideConfirmPassword = !_hideConfirmPassword;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.info10,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.info30),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: theme.onInfo,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Your application will be reviewed by the '
                                  'Bingwa Market admin team. Your account '
                                  'will remain pending until approved.',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    height: 1.5,
                                    color: theme.onInfo,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed:
                                _isSubmitting ? null : _submitApplication,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primary,
                              foregroundColor: theme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isSubmitting
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Submit Application',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        TextButton(
                          onPressed: _isSubmitting
                              ? null
                              : () {
                                  context.goNamed(
                                    BrowseOffersWidget.routeName,
                                  );
                                },
                          child: Text(
                            'Back to Browsing',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: theme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
