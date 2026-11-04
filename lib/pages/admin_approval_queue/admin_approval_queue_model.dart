import '/components/application_card/application_card_widget.dart';
import '/components/approval_tab/approval_tab_widget.dart';
import '/components/button/button_widget.dart';
import '/components/offer_review_row/offer_review_row_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'admin_approval_queue_widget.dart' show AdminApprovalQueueWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminApprovalQueueModel
    extends FlutterFlowModel<AdminApprovalQueueWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ApprovalTab.
  late ApprovalTabModel approvalTabModel1;
  // Model for ApprovalTab.
  late ApprovalTabModel approvalTabModel2;
  // Model for ApplicationCard.
  late ApplicationCardModel applicationCardModel1;
  // Model for ApplicationCard.
  late ApplicationCardModel applicationCardModel2;
  // Model for ApplicationCard.
  late ApplicationCardModel applicationCardModel3;
  // Model for OfferReviewRow.
  late OfferReviewRowModel offerReviewRowModel1;
  // Model for OfferReviewRow.
  late OfferReviewRowModel offerReviewRowModel2;
  // Model for OfferReviewRow.
  late OfferReviewRowModel offerReviewRowModel3;
  // Model for OfferReviewRow.
  late OfferReviewRowModel offerReviewRowModel4;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    approvalTabModel1 = createModel(context, () => ApprovalTabModel());
    approvalTabModel2 = createModel(context, () => ApprovalTabModel());
    applicationCardModel1 = createModel(context, () => ApplicationCardModel());
    applicationCardModel2 = createModel(context, () => ApplicationCardModel());
    applicationCardModel3 = createModel(context, () => ApplicationCardModel());
    offerReviewRowModel1 = createModel(context, () => OfferReviewRowModel());
    offerReviewRowModel2 = createModel(context, () => OfferReviewRowModel());
    offerReviewRowModel3 = createModel(context, () => OfferReviewRowModel());
    offerReviewRowModel4 = createModel(context, () => OfferReviewRowModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    approvalTabModel1.dispose();
    approvalTabModel2.dispose();
    applicationCardModel1.dispose();
    applicationCardModel2.dispose();
    applicationCardModel3.dispose();
    offerReviewRowModel1.dispose();
    offerReviewRowModel2.dispose();
    offerReviewRowModel3.dispose();
    offerReviewRowModel4.dispose();
    buttonModel.dispose();
  }
}
