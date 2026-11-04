import '/components/button/button_widget.dart';
import '/components/offer_row/offer_row_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'browse_offers_widget.dart' show BrowseOffersWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BrowseOffersModel extends FlutterFlowModel<BrowseOffersWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for OfferRow.
  late OfferRowModel offerRowModel1;
  // Model for OfferRow.
  late OfferRowModel offerRowModel2;
  // Model for OfferRow.
  late OfferRowModel offerRowModel3;
  // Model for OfferRow.
  late OfferRowModel offerRowModel4;
  // Model for OfferRow.
  late OfferRowModel offerRowModel5;
  // Model for OfferRow.
  late OfferRowModel offerRowModel6;
  // Model for OfferRow.
  late OfferRowModel offerRowModel7;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    offerRowModel1 = createModel(context, () => OfferRowModel());
    offerRowModel2 = createModel(context, () => OfferRowModel());
    offerRowModel3 = createModel(context, () => OfferRowModel());
    offerRowModel4 = createModel(context, () => OfferRowModel());
    offerRowModel5 = createModel(context, () => OfferRowModel());
    offerRowModel6 = createModel(context, () => OfferRowModel());
    offerRowModel7 = createModel(context, () => OfferRowModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    offerRowModel1.dispose();
    offerRowModel2.dispose();
    offerRowModel3.dispose();
    offerRowModel4.dispose();
    offerRowModel5.dispose();
    offerRowModel6.dispose();
    offerRowModel7.dispose();
    buttonModel.dispose();
  }
}
