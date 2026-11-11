import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminOverviewWidget extends StatefulWidget {
  const AdminOverviewWidget({super.key});

  static String routeName = 'AdminOverview';
  static String routePath = '/adminOverview';

  @override
  State<AdminOverviewWidget> createState() => _AdminOverviewWidgetState();
}

class _AdminOverviewWidgetState extends State<AdminOverviewWidget> {
  void _openApprovalQueue() {
    GoRouter.of(context).goNamed('AdminApprovalQueue');
  }

  Widget _statCard({
    required String title,
    required int value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 23),
          const SizedBox(height: 12),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _pendingAction({
    required String title,
    required String subtitle,
    required int count,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: _openApprovalQueue,
      ),
    );
  }

  Widget _loading() {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _error(String message) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 35),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
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
            Text(
              'Admin Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Marketplace Oversight',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('sellers').snapshots(),
        builder: (context, sellerSnapshot) {
          if (sellerSnapshot.hasError) {
            return _error('Unable to load seller statistics. Check Firestore permissions.');
          }

          if (!sellerSnapshot.hasData) {
            return _loading();
          }

          final sellers = sellerSnapshot.data!.docs;

          final totalSellers = sellers.length;
          final approvedSellers = sellers.where(
            (doc) => doc.data()['approvalStatus'] == 'approved',
          ).length;
          final pendingSellers = sellers.where(
            (doc) => doc.data()['approvalStatus'] == 'pending',
          ).length;

          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance.collection('offers').snapshots(),
            builder: (context, offerSnapshot) {
              if (offerSnapshot.hasError) {
                return _error('Unable to load offer statistics. Check Firestore permissions.');
              }

              if (!offerSnapshot.hasData) {
                return _loading();
              }

              final offers = offerSnapshot.data!.docs;

              final totalOffers = offers.length;
              final publishedOffers = offers.where(
                (doc) =>
                    doc.data()['approvalStatus'] == 'approved' &&
                    doc.data()['isActive'] == true,
              ).length;
              final pendingOffers = offers.where(
                (doc) => doc.data()['approvalStatus'] == 'pending',
              ).length;
              final rejectedOffers = offers.where(
                (doc) => doc.data()['approvalStatus'] == 'rejected',
              ).length;

              return RefreshIndicator(
                onRefresh: () async {
                  await Future.wait([
                    FirebaseFirestore.instance
                        .collection('sellers')
                        .get(const GetOptions(source: Source.server)),
                    FirebaseFirestore.instance
                        .collection('offers')
                        .get(const GetOptions(source: Source.server)),
                  ]);
                },
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text(
                      'System Overview',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),

                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.55,
                      children: [
                        _statCard(
                          title: 'Total Bingwas',
                          value: totalSellers,
                          icon: Icons.people_alt_rounded,
                          color: Colors.blue,
                        ),
                        _statCard(
                          title: 'Approved Bingwas',
                          value: approvedSellers,
                          icon: Icons.verified_user_rounded,
                          color: Colors.green,
                        ),
                        _statCard(
                          title: 'Pending Applications',
                          value: pendingSellers,
                          icon: Icons.person_add_alt_1_rounded,
                          color: Colors.orange,
                        ),
                        _statCard(
                          title: 'Total Offers',
                          value: totalOffers,
                          icon: Icons.shopping_bag_rounded,
                          color: Colors.blue,
                        ),
                        _statCard(
                          title: 'Published Offers',
                          value: publishedOffers,
                          icon: Icons.check_circle_rounded,
                          color: Colors.green,
                        ),
                        _statCard(
                          title: 'Pending Offers',
                          value: pendingOffers,
                          icon: Icons.pending_actions_rounded,
                          color: Colors.orange,
                        ),
                      ],
                    ),

                    _sectionTitle('Pending Actions'),

                    _pendingAction(
                      title: 'Bingwa Applications',
                      subtitle: 'Review new seller registrations',
                      count: pendingSellers,
                      icon: Icons.person_add_rounded,
                    ),

                    _pendingAction(
                      title: 'Offer Reviews',
                      subtitle: 'Approve or reject submitted offers',
                      count: pendingOffers,
                      icon: Icons.rate_review_rounded,
                    ),

                    _sectionTitle('Offer Moderation'),

                    _statCard(
                      title: 'Rejected Offers',
                      value: rejectedOffers,
                      icon: Icons.block_rounded,
                      color: Colors.red,
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _openApprovalQueue,
                        icon: const Icon(Icons.fact_check_rounded),
                        label: const Text('Open Approval Queue'),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Statistics update automatically from Firestore.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}


