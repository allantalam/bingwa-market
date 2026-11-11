import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminApprovalQueueWidget extends StatefulWidget {
  const AdminApprovalQueueWidget({super.key});

  static String routeName = 'AdminApprovalQueue';
  static String routePath = '/adminApprovalQueue';

  @override
  State<AdminApprovalQueueWidget> createState() =>
      _AdminApprovalQueueWidgetState();
}

class _AdminApprovalQueueWidgetState
    extends State<AdminApprovalQueueWidget> {
  final Set<String> _processingIds = {};

  Future<bool> _confirmAction(String title, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showMessage(String message, {bool error = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: error ? Colors.red : Colors.green,
        ),
      );
  }

  Future<void> _reviewSeller(
    String sellerId,
    String status,
  ) async {
    final approved = status == 'approved';

    final confirmed = await _confirmAction(
      approved ? 'Approve Bingwa?' : 'Reject application?',
      approved
          ? 'This seller will be allowed to access the Bingwa Dashboard.'
          : 'This seller application will be rejected.',
    );

    if (!confirmed || !mounted) return;

    setState(() => _processingIds.add(sellerId));

    try {
      await FirebaseFirestore.instance
          .collection('sellers')
          .doc(sellerId)
          .update({'approvalStatus': status});

      _showMessage(
        approved
            ? 'Bingwa application approved.'
            : 'Bingwa application rejected.',
      );
    } catch (e) {
      _showMessage('Could not update application: $e', error: true);
    } finally {
      if (mounted) {
        setState(() => _processingIds.remove(sellerId));
      }
    }
  }

  Future<void> _reviewOffer(
    String offerId,
    String status,
  ) async {
    final approved = status == 'approved';

    final confirmed = await _confirmAction(
      approved ? 'Approve offer?' : 'Reject offer?',
      approved
          ? 'This offer will become active and visible to customers.'
          : 'This offer will be rejected and remain inactive.',
    );

    if (!confirmed || !mounted) return;

    setState(() => _processingIds.add(offerId));

    try {
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .update({
        'approvalStatus': status,
        'isActive': approved,
        'isVerified': approved,
        'lastVerified': FieldValue.serverTimestamp(),
      });

      _showMessage(
        approved ? 'Offer approved and activated.' : 'Offer rejected.',
      );
    } catch (e) {
      _showMessage('Could not update offer: $e', error: true);
    } finally {
      if (mounted) {
        setState(() => _processingIds.remove(offerId));
      }
    }
  }

  Widget _sectionHeading(String title, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '$count pending',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerQueue() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('sellers')
          .where('approvalStatus', isEqualTo: 'pending')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _errorMessage('Unable to load Bingwa applications.');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final sellers = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionHeading('Pending Bingwa Applications', sellers.length),
            if (sellers.isEmpty)
              _emptyMessage('No pending Bingwa applications.')
            else
              ...sellers.map(_buildSellerCard),
          ],
        );
      },
    );
  }

  Widget _buildOfferQueue() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('offers')
          .where('approvalStatus', isEqualTo: 'pending')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _errorMessage('Unable to load pending offers.');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final offers = snapshot.data!.docs;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionHeading('Pending Offer Reviews', offers.length),
            if (offers.isEmpty)
              _emptyMessage('No pending offers.')
            else
              ...offers.map(_buildOfferCard),
          ],
        );
      },
    );
  }

  Widget _buildSellerCard(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    final id = document.id;
    final processing = _processingIds.contains(id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['businessName']?.toString() ?? 'Unnamed business',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _detailLine('Applicant', data['fullName']),
            _detailLine('Email', data['email']),
            _detailLine('Phone', data['phoneNumber']),
            _detailLine('M-Pesa Till', data['tillNumber']),
            _detailLine('Business', data['businessInformation']),
            const SizedBox(height: 12),
            _actionButtons(
              processing: processing,
              onApprove: () => _reviewSeller(id, 'approved'),
              onReject: () => _reviewSeller(id, 'rejected'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    final id = document.id;
    final processing = _processingIds.contains(id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['title']?.toString() ?? 'Untitled offer',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _detailLine('Bingwa', data['sellerName']),
            _detailLine('Category', data['category']),
            _detailLine('Price', 'KSh ${data['price'] ?? '-'}'),
            _detailLine('Details', data['detail']),
            _detailLine('Validity', data['validity']),
            const SizedBox(height: 12),
            _actionButtons(
              processing: processing,
              onApprove: () => _reviewOffer(id, 'approved'),
              onReject: () => _reviewOffer(id, 'rejected'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailLine(String label, dynamic value) {
    final text = value?.toString().trim() ?? '';

    if (text.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        '$label: $text',
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  Widget _actionButtons({
    required bool processing,
    required VoidCallback onApprove,
    required VoidCallback onReject,
  }) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: processing ? null : onReject,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Reject'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton(
            onPressed: processing ? null : onApprove,
            child: processing
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Approve'),
          ),
        ),
      ],
    );
  }

  Widget _emptyMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          message,
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      ),
    );
  }

  Widget _errorMessage(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Approval Queue'),
            Text(
              'Marketplace Moderation',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSellerQueue(),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              _buildOfferQueue(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
