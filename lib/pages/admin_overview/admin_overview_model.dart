import '/components/action_row/action_row_widget.dart';
import '/components/admin_stat/admin_stat_widget.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'admin_overview_widget.dart' show AdminOverviewWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminOverviewModel extends FlutterFlowModel<AdminOverviewWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for AdminStat.
  late AdminStatModel adminStatModel1;
  // Model for AdminStat.
  late AdminStatModel adminStatModel2;
  // Model for ActionRow.
  late ActionRowModel actionRowModel1;
  // Model for ActionRow.
  late ActionRowModel actionRowModel2;
  // Model for ActionRow.
  late ActionRowModel actionRowModel3;

  @override
  void initState(BuildContext context) {
    adminStatModel1 = createModel(context, () => AdminStatModel());
    adminStatModel2 = createModel(context, () => AdminStatModel());
    actionRowModel1 = createModel(context, () => ActionRowModel());
    actionRowModel2 = createModel(context, () => ActionRowModel());
    actionRowModel3 = createModel(context, () => ActionRowModel());
  }

  @override
  void dispose() {
    adminStatModel1.dispose();
    adminStatModel2.dispose();
    actionRowModel1.dispose();
    actionRowModel2.dispose();
    actionRowModel3.dispose();
  }
}
