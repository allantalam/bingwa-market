import '/components/button/button_widget.dart';
import '/components/dash_stat/dash_stat_widget.dart';
import '/components/offer_status_row/offer_status_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'bingwa_dashboard_widget.dart' show BingwaDashboardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BingwaDashboardModel extends FlutterFlowModel<BingwaDashboardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DashStat.
  late DashStatModel dashStatModel1;
  // Model for DashStat.
  late DashStatModel dashStatModel2;
  // Model for DashStat.
  late DashStatModel dashStatModel3;
  // Model for DashStat.
  late DashStatModel dashStatModel4;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for OfferStatusRow.
  late OfferStatusRowModel offerStatusRowModel1;
  // Model for OfferStatusRow.
  late OfferStatusRowModel offerStatusRowModel2;
  // Model for OfferStatusRow.
  late OfferStatusRowModel offerStatusRowModel3;

  @override
  void initState(BuildContext context) {
    dashStatModel1 = createModel(context, () => DashStatModel());
    dashStatModel2 = createModel(context, () => DashStatModel());
    dashStatModel3 = createModel(context, () => DashStatModel());
    dashStatModel4 = createModel(context, () => DashStatModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    offerStatusRowModel1 = createModel(context, () => OfferStatusRowModel());
    offerStatusRowModel2 = createModel(context, () => OfferStatusRowModel());
    offerStatusRowModel3 = createModel(context, () => OfferStatusRowModel());
  }

  @override
  void dispose() {
    dashStatModel1.dispose();
    dashStatModel2.dispose();
    dashStatModel3.dispose();
    dashStatModel4.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    offerStatusRowModel1.dispose();
    offerStatusRowModel2.dispose();
    offerStatusRowModel3.dispose();
  }
}
