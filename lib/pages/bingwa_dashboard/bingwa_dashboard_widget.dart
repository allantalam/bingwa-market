import '/components/button/button_widget.dart';
import '/components/dash_stat/dash_stat_widget.dart';
import '/components/offer_status_row/offer_status_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bingwa_dashboard_model.dart';
export 'bingwa_dashboard_model.dart';
import '/pages/submit_offer/submit_offer_widget.dart';

class BingwaDashboardWidget extends StatefulWidget {
  const BingwaDashboardWidget({super.key});

  static String routeName = 'BingwaDashboard';
  static String routePath = '/bingwaDashboard';

  @override
  State<BingwaDashboardWidget> createState() => _BingwaDashboardWidgetState();
}

class _BingwaDashboardWidgetState extends State<BingwaDashboardWidget> {
  late BingwaDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BingwaDashboardModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Bingwa Dashboard',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            font: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                            lineHeight: 1.3,
                                          ),
                                    ),
                                    Text(
                                      'Manage your marketplace offers',
                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                            lineHeight: 1.4,
                                          ),
                                    ),
                                  ].divide(const SizedBox(height: 4.0)),
                                ),
                                FlutterFlowIconButton(
                                  borderRadius: 8.0,
                                  buttonSize: 40.0,
                                  fillColor: Colors.transparent,
                                  icon: Icon(
                                    Icons.logout_rounded,
                                    color: FlutterFlowTheme.of(context).error,
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).success10,
                                borderRadius: BorderRadius.circular(12.0),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).success30,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.verified_user_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .onSuccess,
                                        size: 18.0,
                                      ),
                                      Text(
                                        'Account Status: Approved Bingwa',
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              font: GoogleFonts.spaceGrotesk(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .onSuccess,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelLarge
                                                      .fontStyle,
                                              lineHeight: 1.3,
                                            ),
                                      ),
                                    ].divide(const SizedBox(width: 8.0)),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).alternate,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseAuth.instance.currentUser == null
                    ? const Stream.empty()
                    : FirebaseFirestore.instance
                        .collection('offers')
                        .where(
                          'sellerId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                        )
                        .snapshots(),
                builder: (context, snapshot) {
                  final offers = snapshot.data?.docs ?? [];
                  final totalOffers = offers.length;
                  final activeOffers = offers.where((doc) {
                    final data = doc.data();
                    return (data['approvalStatus']?.toString().toLowerCase() ==
                            'approved') &&
                        data['isActive'] == true;
                  }).length;
                  final pendingOffers = offers.where((doc) =>
                      doc.data()['approvalStatus']
                          ?.toString()
                          .toLowerCase() ==
                      'pending').length;
                  final rejectedOffers = offers.where((doc) =>
                      doc.data()['approvalStatus']
                          ?.toString()
                          .toLowerCase() ==
                      'rejected').length;

                  String statValue(int value) =>
                      snapshot.hasError ? '—' : value.toString();

                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DashStatWidget(
                                icon: Icon(
                                  Icons.local_offer_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20.0,
                                ),
                                label: 'Total Offers',
                                tone: FlutterFlowTheme.of(context).primary,
                                value: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? '...'
                                    : statValue(totalOffers),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: DashStatWidget(
                                icon: Icon(
                                  Icons.check_circle_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20.0,
                                ),
                                label: 'Active Offers',
                                tone: FlutterFlowTheme.of(context).tertiary,
                                value: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? '...'
                                    : statValue(activeOffers),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: DashStatWidget(
                                icon: Icon(
                                  Icons.history_toggle_off_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20.0,
                                ),
                                label: 'Pending Review',
                                tone: FlutterFlowTheme.of(context).warning,
                                value: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? '...'
                                    : statValue(pendingOffers),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: DashStatWidget(
                                icon: Icon(
                                  Icons.cancel_rounded,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 20.0,
                                ),
                                label: 'Rejected Offers',
                                tone: FlutterFlowTheme.of(context).error,
                                value: snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? '...'
                                    : statValue(rejectedOffers),
                              ),
                            ),
                          ],
                        ),
                        if (snapshot.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Unable to load offer statistics.',
                              style: FlutterFlowTheme.of(context).bodySmall,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    wrapWithModel(
                      model: _model.buttonModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        icon: Icon(
                          Icons.add_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        content: 'Submit New Offer',
                        variant: 'primary',
                        size: 'large',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                        onTap: () {
                        context.pushNamed(SubmitOfferWidget.routeName);
                        },
                      ),
                    ),
                    wrapWithModel(
                      model: _model.buttonModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        icon: Icon(
                          Icons.list_alt_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        iconPresent: true,
                        iconEndPresent: false,
                        content: 'View My Submitted Offers',
                        variant: 'outline',
                        size: 'medium',
                        fullWidth: true,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ].divide(const SizedBox(height: 16.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent Submissions',
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    font: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                        ),
                        Text(
                          'View all',
                          style:
                              FlutterFlowTheme.of(context).labelLarge.override(
                                    font: GoogleFonts.spaceGrotesk(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelLarge
                                        .fontStyle,
                                    lineHeight: 1.3,
                                  ),
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseAuth.instance.currentUser == null
                          ? const Stream.empty()
                          : FirebaseFirestore.instance
                              .collection('offers')
                              .where(
                                'sellerId',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid,
                              )
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Unable to load your submissions. Please try again.',
                              style: FlutterFlowTheme.of(context).bodySmall,
                            ),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final offers = [...?snapshot.data?.docs];
                        offers.sort((a, b) {
                          final aDate = a.data()['createdAt'];
                          final bDate = b.data()['createdAt'];
                          final aMillis = aDate is Timestamp
                              ? aDate.millisecondsSinceEpoch
                              : 0;
                          final bMillis = bDate is Timestamp
                              ? bDate.millisecondsSinceEpoch
                              : 0;
                          return bMillis.compareTo(aMillis);
                        });

                        if (offers.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'You have not submitted any offers yet.',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          );
                        }

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: offers.take(5).map((offer) {
                            final data = offer.data();
                            final title =
                                data['title']?.toString().trim().isNotEmpty ==
                                        true
                                    ? data['title'].toString()
                                    : 'Untitled offer';
                            final rawStatus =
                                data['approvalStatus']?.toString().toLowerCase() ??
                                    'pending';
                            final status = rawStatus == 'approved'
                                ? 'Published'
                                : rawStatus == 'rejected'
                                    ? 'Rejected'
                                    : 'Pending Review';
                            final statusColor = rawStatus == 'approved'
                                ? FlutterFlowTheme.of(context).success
                                : rawStatus == 'rejected'
                                    ? FlutterFlowTheme.of(context).error
                                    : FlutterFlowTheme.of(context).warning;
                            final price = data['price']?.toString() ?? '—';

                            return OfferStatusRowWidget(
                              price: price,
                              status: status,
                              statusColor: statusColor,
                              title: title,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ].divide(const SizedBox(height: 16.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Business Settings',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseAuth.instance.currentUser == null
                          ? null
                          : FirebaseFirestore.instance
                              .collection('sellers')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                      builder: (context, snapshot) {
                        final currentUser = FirebaseAuth.instance.currentUser;
                        final sellerData = snapshot.data?.data();

                        var businessName = 'Loading...';
                        var tillNumber = 'Loading...';

                        if (currentUser == null) {
                          businessName = 'Not signed in';
                          tillNumber = 'Not signed in';
                        } else if (snapshot.hasError) {
                          businessName = 'Unable to load';
                          tillNumber = 'Unable to load';
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          businessName = 'Loading...';
                          tillNumber = 'Loading...';
                        } else if (snapshot.data?.exists != true) {
                          businessName = 'Seller profile not found';
                          tillNumber = 'Seller profile not found';
                        } else {
                          final savedBusinessName =
                              sellerData?['businessName']?.toString().trim();
                          final savedTillNumber =
                              sellerData?['tillNumber']?.toString().trim();

                          businessName =
                              savedBusinessName?.isNotEmpty == true
                                  ? savedBusinessName!
                                  : 'Not provided';
                          tillNumber = savedTillNumber?.isNotEmpty == true
                              ? savedTillNumber!
                              : 'Not provided';
                        }

                        return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 16.0, 24.0, 16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.store_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Business Name',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .spaceGrotesk(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.2,
                                                      ),
                                            ),
                                            Text(
                                              businessName,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                            ),
                                          ].divide(const SizedBox(height: 4.0)),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(const SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 16.0, 24.0, 16.0),
                                child: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.point_of_sale_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'M-Pesa Till Number',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts
                                                            .spaceGrotesk(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                        lineHeight: 1.2,
                                                      ),
                                            ),
                                            Text(
                                              tillNumber,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                        lineHeight: 1.5,
                                                      ),
                                            ),
                                          ].divide(const SizedBox(height: 4.0)),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ].divide(const SizedBox(width: 16.0)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                        );
                      },
                    ),
                  ].divide(const SizedBox(height: 16.0)),
                ),
              ),
              Container(
                height: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
