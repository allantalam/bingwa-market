
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/components/button/button_widget.dart';
import '/components/offer_row/offer_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

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

  // FILTER SETTINGS
  String _priceSort = 'Recommended';
  String _validityFilter = 'All';
  bool _verifiedOnly = false;

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

  // NUMBER OF ACTIVE FILTERS
  int get _activeFilterCount {
    int count = 0;

    if (_priceSort != 'Recommended') count++;
    if (_validityFilter != 'All') count++;
    if (_verifiedOnly) count++;

    return count;
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

  // CONVERT PRICE TO NUMBER FOR SORTING
  double _priceNumber(dynamic value) {
    if (value == null) return 0;

    if (value is num) return value.toDouble();

    return double.tryParse(
          value.toString().replaceAll(',', '').trim(),
        ) ??
        0;
  }

  // FORMAT PRICE WITH THOUSANDS SEPARATORS
  String _formatPrice(dynamic value) {
    if (value == null) return '0';

    final number = value is num
        ? value
        : num.tryParse(value.toString().replaceAll(',', ''));

    if (number == null) return value.toString();

    final text = number % 1 == 0
        ? number.toInt().toString()
        : number.toString();

    return text.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }

  // CHECK WHETHER AN OFFER MATCHES THE SELECTED VALIDITY
  bool _matchesValidity(String validity) {
    if (_validityFilter == 'All') return true;

    final value = validity.toLowerCase();

    switch (_validityFilter) {
      case 'Hourly':
        return value.contains('hour') &&
            !value.contains('24 hour');

      case 'Daily':
        return value.contains('day') ||
            value.contains('24 hour') ||
            value.contains('24-hour');

      case 'Weekly':
        return value.contains('week');

      case 'Monthly':
        return value.contains('month');

      default:
        return true;
    }
  }

  // OPEN FILTER PANEL
  void _openFilterPanel() {
    String tempPriceSort = _priceSort;
    String tempValidityFilter = _validityFilter;
    bool tempVerifiedOnly = _verifiedOnly;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          FlutterFlowTheme.of(context).secondaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PANEL HANDLE
                      Center(
                        child: Container(
                          width: 42,
                          height: 5,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .alternate,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // PANEL TITLE
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Filter offers',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(sheetContext);
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // PRICE SORT
                      Text(
                        'Sort by price',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                        ),
                      ),

                      const SizedBox(height: 10),

                      RadioListTile<String>(
                        value: 'Recommended',
                        groupValue: tempPriceSort,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Recommended'),
                        activeColor:
                            FlutterFlowTheme.of(context).primary,
                        onChanged: (value) {
                          if (value == null) return;
                          setModalState(() {
                            tempPriceSort = value;
                          });
                        },
                      ),

                      RadioListTile<String>(
                        value: 'Low to High',
                        groupValue: tempPriceSort,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Lowest price first'),
                        activeColor:
                            FlutterFlowTheme.of(context).primary,
                        onChanged: (value) {
                          if (value == null) return;
                          setModalState(() {
                            tempPriceSort = value;
                          });
                        },
                      ),

                      RadioListTile<String>(
                        value: 'High to Low',
                        groupValue: tempPriceSort,
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Highest price first'),
                        activeColor:
                            FlutterFlowTheme.of(context).primary,
                        onChanged: (value) {
                          if (value == null) return;
                          setModalState(() {
                            tempPriceSort = value;
                          });
                        },
                      ),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 16),

                      // VALIDITY FILTER
                      Text(
                        'Offer validity',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          'All',
                          'Hourly',
                          'Daily',
                          'Weekly',
                          'Monthly',
                        ].map((validity) {
                          final selected =
                              tempValidityFilter == validity;

                          return ChoiceChip(
                            label: Text(validity),
                            selected: selected,
                            onSelected: (value) {
                              setModalState(() {
                                tempValidityFilter = validity;
                              });
                            },
                            selectedColor:
                                FlutterFlowTheme.of(context).primary,
                            labelStyle: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : FlutterFlowTheme.of(context)
                                      .primaryText,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),
                      const Divider(),

                      // VERIFIED SELLERS FILTER
                      CheckboxListTile(
                        value: tempVerifiedOnly,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity:
                            ListTileControlAffinity.leading,
                        activeColor:
                            FlutterFlowTheme.of(context).primary,
                        title: const Text(
                          'Verified Bingwas only',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Text(
                          'Show offers from verified sellers only.',
                        ),
                        onChanged: (value) {
                          setModalState(() {
                            tempVerifiedOnly = value ?? false;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      // RESET AND APPLY BUTTONS
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                setModalState(() {
                                  tempPriceSort = 'Recommended';
                                  tempValidityFilter = 'All';
                                  tempVerifiedOnly = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: const Text('Reset filters'),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                safeSetState(() {
                                  _priceSort = tempPriceSort;
                                  _validityFilter =
                                      tempValidityFilter;
                                  _verifiedOnly = tempVerifiedOnly;
                                });

                                Navigator.pop(sheetContext);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    FlutterFlowTheme.of(context)
                                        .primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              child: const Text('Apply filters'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // FILTER BUTTON
  Widget _filterButton() {
    return OutlinedButton.icon(
      onPressed: _openFilterPanel,
      icon: const Icon(Icons.tune_rounded, size: 18),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Filter'),
          if (_activeFilterCount > 0) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_activeFilterCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor:
            FlutterFlowTheme.of(context).primaryText,
        side: BorderSide(
          color: FlutterFlowTheme.of(context).alternate,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  // BUILD ONE OFFER FROM FIRESTORE
  Widget _buildOfferFromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();

    final category = (data['category'] ?? '').toString();
    final title = (data['title'] ?? 'Untitled Offer').toString();
    final detail = (data['detail'] ?? '').toString();
    final price = _formatPrice(data['price']);
    final validity = (data['validity'] ?? '').toString();

    final verified = data['isVerified'] == true;

    if (data['isActive'] != true ||
        !_matchesCategory(category) ||
        !_matchesSearch(
          category: category,
          title: title,
          detail: detail,
          price: price,
          validity: validity,
        ) ||
        !_matchesValidity(validity) ||
        (_verifiedOnly && !verified)) {
      return const SizedBox.shrink();
    }

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        OfferDetailsWidget.selectedTitle = title;
        OfferDetailsWidget.selectedCategory = category;
        OfferDetailsWidget.selectedDetail = detail;
        OfferDetailsWidget.selectedPrice = price;
        OfferDetailsWidget.selectedValidity = validity;

        OfferDetailsWidget.selectedSeller =
            (data['sellerName'] ?? 'Verified Bingwa').toString();

        OfferDetailsWidget.selectedLastVerified =
            (data['lastVerified'] ?? 'Recently verified').toString();

        context.goNamed(OfferDetailsWidget.routeName);
      },
      child: OfferRowWidget(
        detail: detail,
        price: price,
        title: title,
        validity: validity,
        verified: verified,
      ),
    );
  }

  // EMPTY RESULTS MESSAGE
  Widget _emptyResults() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
          const SizedBox(height: 12),
          Text(
            'No offers found',
            style: FlutterFlowTheme.of(context).titleMedium,
          ),
          const SizedBox(height: 6),
          Text(
            'Try another search or category, or reset your filters.',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
        ],
      ),
    );
  }

  // FIRESTORE OFFER LIST
  Widget _buildFirestoreOffers() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('offers')
          .where('approvalStatus', isEqualTo: 'approved')
          .where('isActive', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Unable to load offers. Please try again later.\n'
              '${snapshot.error}',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final documents = snapshot.data?.docs ?? [];

        // Only active, approved offers are displayed.
        final activeDocuments = documents.where((document) {
          return document.data()['isActive'] == true;
        }).toList();

        // Keep recommended order unless price sorting is selected.
        if (_priceSort == 'Low to High') {
          activeDocuments.sort((a, b) {
            return _priceNumber(a.data()['price'])
                .compareTo(_priceNumber(b.data()['price']));
          });
        } else if (_priceSort == 'High to Low') {
          activeDocuments.sort((a, b) {
            return _priceNumber(b.data()['price'])
                .compareTo(_priceNumber(a.data()['price']));
          });
        } else {
          activeDocuments.sort((a, b) {
            final aOrder =
                a.data()['sortOrder'] as num? ?? 999999;
            final bOrder =
                b.data()['sortOrder'] as num? ?? 999999;

            return aOrder.compareTo(bOrder);
          });
        }

        final matchingDocuments = activeDocuments.where((document) {
          final data = document.data();

          final category = (data['category'] ?? '').toString();
          final title = (data['title'] ?? '').toString();
          final detail = (data['detail'] ?? '').toString();
          final price = _formatPrice(data['price']);
          final validity = (data['validity'] ?? '').toString();
          final verified = data['isVerified'] == true;

          return _matchesCategory(category) &&
              _matchesSearch(
                category: category,
                title: title,
                detail: detail,
                price: price,
                validity: validity,
              ) &&
              _matchesValidity(validity) &&
              (!_verifiedOnly || verified);
        }).toList();

        if (matchingDocuments.isEmpty) {
          return _emptyResults();
        }

        return Column(
          children: matchingDocuments
              .map(_buildOfferFromFirestore)
              .toList(),
        );
      },
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
                              color:
                                  FlutterFlowTheme.of(context).primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.shopping_basket_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .onPrimary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Bingwa Market',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: FlutterFlowTheme.of(context)
                                  .primaryText,
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
                          color: FlutterFlowTheme.of(context)
                              .primaryText,
                          size: 24,
                        ),
                        onPressed: () {
                          context.goNamed(SavedOffersWidget.routeName);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // SEARCH FIELD
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .primaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            FlutterFlowTheme.of(context).alternate,
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
                        hintText:
                            'Search bundles, minutes, or Bingwas',
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
                        contentPadding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // FILTER BUTTON BELOW SEARCH
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _filterButton(),
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

            // LIVE FIRESTORE OFFERS
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: _buildFirestoreOffers(),
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
                      FlutterFlowTheme.of(context)
                          .primaryBackground,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: InkWell(
                  onTap: () {
                    context.goNamed(
                      BecomeABingwaWidget.routeName,
                    );
                  },
                  child: wrapWithModel(
                    model: _model.buttonModel,
                    updateCallback: () => safeSetState(() {}),
                    child: ButtonWidget(
                      icon: Icon(
                        Icons.person_add_rounded,
                        color: FlutterFlowTheme.of(context)
                            .primaryText,
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
}
