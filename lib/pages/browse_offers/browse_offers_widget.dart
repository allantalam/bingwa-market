
import '/components/button/button_widget.dart';
import '/components/offer_row/offer_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'browse_offers_model.dart';
export 'browse_offers_model.dart';

class BrowseOffersWidget extends StatefulWidget {
  const BrowseOffersWidget({super.key});

  static String routeName = 'BrowseOffers';
  static String routePath = '/browseOffers';

  @override
  State<BrowseOffersWidget> createState() =>
      _BrowseOffersWidgetState();
}

class _BrowseOffersWidgetState extends State<BrowseOffersWidget> {
  late BrowseOffersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String _selectedCategory = 'All';
  String _searchQuery = '';

  final TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BrowseOffersModel());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _model.dispose();
    super.dispose();
  }

  // CATEGORY BUTTON
  Widget _categoryChip(String category) {
    final bool selected = _selectedCategory == category;

    return InkWell(
      borderRadius: BorderRadius.circular(9999),
      onTap: () {
        safeSetState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: selected
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected)
              const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16,
              ),
            if (selected) const SizedBox(width: 5),
            Text(
              category,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected
                    ? Colors.white
                    : FlutterFlowTheme.of(context).primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CATEGORY FILTER
  bool _matchesCategory(String category) {
    if (_selectedCategory == 'All') return true;

    return category == _selectedCategory;
  }

  // SEARCH FILTER
  bool _matchesSearch({
    required String category,
    required String title,
    required String detail,
    required String price,
    required String validity,
  }) {
    final query = _searchQuery.trim().toLowerCase();

    if (query.isEmpty) return true;

    final searchableText = [
      category,
      title,
      detail,
      price,
      validity,
    ].join(' ').toLowerCase();

    return searchableText.contains(query);
  }

  // OFFER ROW WITH DYNAMIC DETAILS NAVIGATION
  Widget _buildOffer({
    required String category,
    required String detail,
    required String price,
    required String title,
    required String validity,
  }) {
    if (!_matchesCategory(category) ||
        !_matchesSearch(
          category: category,
          title: title,
          detail: detail,
          price: price,
          validity: validity,
        )) {
      return const SizedBox.shrink();
    }

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        // Pass the selected offer information
        // to the Offer Details page.
        OfferDetailsWidget.selectedTitle = title;
        OfferDetailsWidget.selectedCategory = category;
        OfferDetailsWidget.selectedDetail = detail;
        OfferDetailsWidget.selectedPrice = price;
        OfferDetailsWidget.selectedValidity = validity;

        context.goNamed(OfferDetailsWidget.routeName);
      },
      child: OfferRowWidget(
        detail: detail,
        price: price,
        title: title,
        validity: validity,
        verified: true,
      ),
    );
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
        backgroundColor:
            FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER AND SEARCH
            Container(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.shopping_basket_rounded,
                              color: FlutterFlowTheme.of(context).onPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Bingwa Market',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ],
                      ),
                      FlutterFlowIconButton(
                        borderRadius: 8,
                        buttonSize: 40,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.bookmark_border_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24,
                        ),
                        onPressed: () {
                          context.goNamed(SavedOffersWidget.routeName);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // FUNCTIONAL SEARCH FIELD
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        safeSetState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search bundles, minutes, or Bingwas',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  _searchController.clear();
                                  safeSetState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CATEGORY FILTERS
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _categoryChip('All'),
                    const SizedBox(width: 8),
                    _categoryChip('Bundles'),
                    const SizedBox(width: 8),
                    _categoryChip('Minutes'),
                    const SizedBox(width: 8),
                    _categoryChip('SMS'),
                    const SizedBox(width: 8),
                    _categoryChip('Special Offers'),
                  ],
                ),
              ),
            ),

            // FILTERED AND SEARCHED OFFERS
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      _buildOffer(
                        category: 'Bundles',
                        detail: '500MB Data',
                        price: '20',
                        title: 'Power Hour Bundle',
                        validity: '1 Hour',
                      ),

                      _buildOffer(
                        category: 'SMS',
                        detail: '200 SMS',
                        price: '10',
                        title: 'Daily SMS Max',
                        validity: '24 Hours',
                      ),

                      _buildOffer(
                        category: 'Minutes',
                        detail: '150 Mins Any Net',
                        price: '450',
                        title: 'Weekly Minutes Pro',
                        validity: '7 Days',
                      ),

                      _buildOffer(
                        category: 'Bundles',
                        detail: '15GB + 400 Mins',
                        price: '2,000',
                        title: 'Monthly Heavyweight',
                        validity: '30 Days',
                      ),

                      _buildOffer(
                        category: 'Special Offers',
                        detail: 'Unlimited WhatsApp/FB',
                        price: '50',
                        title: 'Social Pass',
                        validity: '24 Hours',
                      ),

                      _buildOffer(
                        category: 'Bundles',
                        detail: '5GB Night Only',
                        price: '100',
                        title: 'Night Owl Data',
                        validity: '12 AM - 6 AM',
                      ),

                      _buildOffer(
                        category: 'Minutes',
                        detail: '1000 Mins Business',
                        price: '1,500',
                        title: 'Biashara Talk',
                        validity: '30 Days',
                      ),

                      // NO RESULTS MESSAGE
                      if (!_hasMatchingOffers())
                        Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 42,
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'No offers found',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Try another search or category.',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // BECOME A BINGWA BUTTON
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primaryBackground,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: InkWell(
                  onTap: () {
                    context.goNamed(BecomeABingwaWidget.routeName);
                  },
                  child: wrapWithModel(
                    model: _model.buttonModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      icon: Icon(
                        Icons.person_add_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24,
                      ),
                      iconPresent: true,
                      iconEndPresent: false,
                      content: 'Become a Bingwa',
                      variant: 'outline',
                      size: 'medium',
                      fullWidth: true,
                      loading: false,
                      disabled: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CHECK WHETHER ANY OFFER MATCHES
  bool _hasMatchingOffers() {
    final offers = [
      {
        'category': 'Bundles',
        'detail': '500MB Data',
        'price': '20',
        'title': 'Power Hour Bundle',
        'validity': '1 Hour',
      },
      {
        'category': 'SMS',
        'detail': '200 SMS',
        'price': '10',
        'title': 'Daily SMS Max',
        'validity': '24 Hours',
      },
      {
        'category': 'Minutes',
        'detail': '150 Mins Any Net',
        'price': '450',
        'title': 'Weekly Minutes Pro',
        'validity': '7 Days',
      },
      {
        'category': 'Bundles',
        'detail': '15GB + 400 Mins',
        'price': '2,000',
        'title': 'Monthly Heavyweight',
        'validity': '30 Days',
      },
      {
        'category': 'Special Offers',
        'detail': 'Unlimited WhatsApp/FB',
        'price': '50',
        'title': 'Social Pass',
        'validity': '24 Hours',
      },
      {
        'category': 'Bundles',
        'detail': '5GB Night Only',
        'price': '100',
        'title': 'Night Owl Data',
        'validity': '12 AM - 6 AM',
      },
      {
        'category': 'Minutes',
        'detail': '1000 Mins Business',
        'price': '1,500',
        'title': 'Biashara Talk',
        'validity': '30 Days',
      },
    ];

    return offers.any((offer) {
      return _matchesCategory(offer['category']!) &&
          _matchesSearch(
            category: offer['category']!,
            title: offer['title']!,
            detail: offer['detail']!,
            price: offer['price']!,
            validity: offer['validity']!,
          );
    });
  }
}
