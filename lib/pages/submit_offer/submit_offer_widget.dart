
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubmitOfferWidget extends StatefulWidget {
  const SubmitOfferWidget({super.key});

  static const String routeName = 'SubmitOffer';
  static const String routePath = '/submitOffer';

  @override
  State<SubmitOfferWidget> createState() => _SubmitOfferWidgetState();
}

class _SubmitOfferWidgetState extends State<SubmitOfferWidget> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String _category = 'Bundles';
  String _validity = 'Daily';
  bool _isSubmitting = false;

  final List<String> _categories = [
    'Bundles',
    'Minutes',
    'SMS',
    'Special Offers',
  ];

  final List<String> _validities = [
    '1 Hour',
    'Daily',
    'Weekly',
    'Monthly',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submitOffer() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage('Please log in to submit an offer.');
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final sellerSnapshot = await FirebaseFirestore.instance
          .collection('sellers')
          .doc(user.uid)
          .get();

      if (!sellerSnapshot.exists) {
        throw Exception('Seller profile not found.');
      }

      final sellerData = sellerSnapshot.data()!;
      final approvalStatus =
          sellerData['approvalStatus']?.toString();

      if (approvalStatus != 'approved') {
        _showMessage(
          'Your Bingwa account must be approved before you can submit offers.',
        );
        return;
      }

      final businessName =
          sellerData['businessName']?.toString() ?? 'Bingwa Seller';

      final price = double.parse(_priceController.text.trim());

      await FirebaseFirestore.instance.collection('offers').add({
        'title': _titleController.text.trim(),
        'category': _category,
        'detail': _detailController.text.trim(),
        'description': _descriptionController.text.trim(),
        'price': price,
        'validity': _validity,
        'sellerId': user.uid,
        'sellerName': businessName,
        'approvalStatus': 'pending',
        'isActive': false,
        'isVerified': false,
        'lastVerified': 'Awaiting review',
        'sortOrder': 9999,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      _titleController.clear();
      _detailController.clear();
      _descriptionController.clear();
      _priceController.clear();

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Offer submitted'),
          content: const Text(
            'Your offer has been submitted successfully. '
            'It will appear in Bingwa Market after admin approval.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (mounted) Navigator.pop(context);
    } on FirebaseException catch (e) {
      _showMessage('Submission failed: ${e.message ?? e.code}');
    } catch (e) {
      _showMessage(
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit New Offer'),
        backgroundColor: const Color(0xFF087443),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Offer information',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter accurate offer details. Your submission will '
                'be reviewed before it appears in the marketplace.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _titleController,
                decoration: _decoration(
                  'Offer title',
                  hint: 'e.g. 1GB Daily Bundle',
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter an offer title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: _decoration('Category'),
                items: _categories
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _category = value);
                  }
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _detailController,
                decoration: _decoration(
                  'Offer details',
                  hint: 'e.g. 1GB data or 100 SMS',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter the offer details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _priceController,
                decoration: _decoration(
                  'Price (KSh)',
                  hint: 'e.g. 20',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final price =
                      double.tryParse(value?.trim() ?? '');

                  if (price == null || price <= 0) {
                    return 'Enter a valid price greater than zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: _validity,
                decoration: _decoration('Validity'),
                items: _validities
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _validity = value);
                  }
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descriptionController,
                decoration: _decoration(
                  'Additional description (optional)',
                  hint: 'Add any important conditions or details',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 28),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitOffer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF087443),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Submit for Approval',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Note: Submitting an offer does not publish it '
                'immediately. Admin approval is required.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
