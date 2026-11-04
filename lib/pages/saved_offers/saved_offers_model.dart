import '/components/saved_offer_row/saved_offer_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'saved_offers_widget.dart' show SavedOffersWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SavedOffersModel extends FlutterFlowModel<SavedOffersWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SavedOfferRow.
  late SavedOfferRowModel savedOfferRowModel1;
  // Model for SavedOfferRow.
  late SavedOfferRowModel savedOfferRowModel2;
  // Model for SavedOfferRow.
  late SavedOfferRowModel savedOfferRowModel3;
  // Model for SavedOfferRow.
  late SavedOfferRowModel savedOfferRowModel4;
  // Model for SavedOfferRow.
  late SavedOfferRowModel savedOfferRowModel5;

  @override
  void initState(BuildContext context) {
    savedOfferRowModel1 = createModel(context, () => SavedOfferRowModel());
    savedOfferRowModel2 = createModel(context, () => SavedOfferRowModel());
    savedOfferRowModel3 = createModel(context, () => SavedOfferRowModel());
    savedOfferRowModel4 = createModel(context, () => SavedOfferRowModel());
    savedOfferRowModel5 = createModel(context, () => SavedOfferRowModel());
  }

  @override
  void dispose() {
    savedOfferRowModel1.dispose();
    savedOfferRowModel2.dispose();
    savedOfferRowModel3.dispose();
    savedOfferRowModel4.dispose();
    savedOfferRowModel5.dispose();
  }
}
