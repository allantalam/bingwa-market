import '/components/button/button_widget.dart';
import '/components/report_reason_item/report_reason_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'report_offer_widget.dart' show ReportOfferWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReportOfferModel extends FlutterFlowModel<ReportOfferWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ReportReasonItem.
  late ReportReasonItemModel reportReasonItemModel1;
  // Model for ReportReasonItem.
  late ReportReasonItemModel reportReasonItemModel2;
  // Model for ReportReasonItem.
  late ReportReasonItemModel reportReasonItemModel3;
  // Model for ReportReasonItem.
  late ReportReasonItemModel reportReasonItemModel4;
  // Model for ReportReasonItem.
  late ReportReasonItemModel reportReasonItemModel5;
  // Model for ReportReasonItem.
  late ReportReasonItemModel reportReasonItemModel6;
  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    reportReasonItemModel1 =
        createModel(context, () => ReportReasonItemModel());
    reportReasonItemModel2 =
        createModel(context, () => ReportReasonItemModel());
    reportReasonItemModel3 =
        createModel(context, () => ReportReasonItemModel());
    reportReasonItemModel4 =
        createModel(context, () => ReportReasonItemModel());
    reportReasonItemModel5 =
        createModel(context, () => ReportReasonItemModel());
    reportReasonItemModel6 =
        createModel(context, () => ReportReasonItemModel());
    textFieldModel = createModel(context, () => TextFieldModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    reportReasonItemModel1.dispose();
    reportReasonItemModel2.dispose();
    reportReasonItemModel3.dispose();
    reportReasonItemModel4.dispose();
    reportReasonItemModel5.dispose();
    reportReasonItemModel6.dispose();
    textFieldModel.dispose();
    buttonModel.dispose();
  }
}
