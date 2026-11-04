import '/components/button/button_widget.dart';
import '/components/detail_row/detail_row_widget.dart';
import '/components/verified_badge/verified_badge_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'offer_details_widget.dart' show OfferDetailsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OfferDetailsModel extends FlutterFlowModel<OfferDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for VerifiedBadge.
  late VerifiedBadgeModel verifiedBadgeModel;
  // Model for DetailRow.
  late DetailRowModel detailRowModel1;
  // Model for DetailRow.
  late DetailRowModel detailRowModel2;
  // Model for DetailRow.
  late DetailRowModel detailRowModel3;
  // Model for DetailRow.
  late DetailRowModel detailRowModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    verifiedBadgeModel = createModel(context, () => VerifiedBadgeModel());
    detailRowModel1 = createModel(context, () => DetailRowModel());
    detailRowModel2 = createModel(context, () => DetailRowModel());
    detailRowModel3 = createModel(context, () => DetailRowModel());
    detailRowModel4 = createModel(context, () => DetailRowModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    verifiedBadgeModel.dispose();
    detailRowModel1.dispose();
    detailRowModel2.dispose();
    detailRowModel3.dispose();
    detailRowModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}
