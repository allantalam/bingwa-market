import '/components/button/button_widget.dart';
import '/components/feature_item/feature_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'become_a_bingwa_model.dart';
export 'become_a_bingwa_model.dart';

class BecomeABingwaWidget extends StatefulWidget {
  const BecomeABingwaWidget({super.key});

  static String routeName = 'BecomeABingwa';
  static String routePath = '/becomeABingwa';

  @override
  State<BecomeABingwaWidget> createState() => _BecomeABingwaWidgetState();
}

class _BecomeABingwaWidgetState extends State<BecomeABingwaWidget> {
  late BecomeABingwaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BecomeABingwaModel());
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
                  color: FlutterFlowTheme.of(context).primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.0),
                    bottomRight: Radius.circular(32.0),
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 32.0, 24.0, 32.0),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Become a Bingwa',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).onPrimary,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                                lineHeight: 1.25,
                              ),
                        ),
                        Text(
                          'Join Kenya\'s leading marketplace for mobile bundles and earn by helping customers find the best deals.',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).onPrimary90,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                                lineHeight: 1.5,
                              ),
                        ),
                      ].divide(SizedBox(height: 16.0)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    wrapWithModel(
                      model: _model.featureItemModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureItemWidget(
                        desc:
                            'Submit data, minutes, and SMS bundles for administrative review and publication.',
                        icon: Icon(
                          Icons.store_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        title: 'List Your Offers',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.featureItemModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureItemWidget(
                        desc:
                            'Get your offers verified by admins to increase visibility and customer confidence.',
                        icon: Icon(
                          Icons.verified_user_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        title: 'Build Trust',
                      ),
                    ),
                    wrapWithModel(
                      model: _model.featureItemModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: FeatureItemWidget(
                        desc:
                            'Receive payments directly to your M-Pesa Till number from verified customers.',
                        icon: Icon(
                          Icons.payments_rounded,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 20.0,
                        ),
                        title: 'Direct Payments',
                      ),
                    ),
                  ].divide(SizedBox(height: 24.0)),
                ),
              ),
              Divider(
                height: 16.0,
                thickness: 1.0,
                indent: 24.0,
                endIndent: 24.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Bingwa Application',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleLarge
                                .fontStyle,
                            lineHeight: 1.3,
                          ),
                    ),
                    Text(
                      'Please provide your business details to apply for an agent account.',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodySmall
                                .fontStyle,
                            lineHeight: 1.4,
                          ),
                    ),
                    Container(
                      height: 8.0,
                    ),
                    wrapWithModel(
                      model: _model.textFieldModel1,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: 'Full Name',
                        labelPresent: true,
                        helper: '',
                        helperPresent: false,
                        leadingIcon: Icon(
                          Icons.person_outline_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        leadingIconPresent: true,
                        trailingIconPresent: false,
                        hint: 'Enter your legal name',
                        value: '',
                        onChange: '',
                        onSubmit: '',
                        variant: 'outlined',
                        error: false,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.textFieldModel2,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: 'Email Address',
                        labelPresent: true,
                        helper: '',
                        helperPresent: false,
                        leadingIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        leadingIconPresent: true,
                        trailingIconPresent: false,
                        hint: 'email@example.com',
                        value: '',
                        onChange: '',
                        onSubmit: '',
                        variant: 'outlined',
                        error: false,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.textFieldModel3,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: 'Phone Number',
                        labelPresent: true,
                        helper: '',
                        helperPresent: false,
                        leadingIcon: Icon(
                          Icons.phone_android_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        leadingIconPresent: true,
                        trailingIconPresent: false,
                        hint: '07XXXXXXXX',
                        value: '',
                        onChange: '',
                        onSubmit: '',
                        variant: 'outlined',
                        error: false,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 8.0),
                      child: Divider(
                        height: 16.0,
                        thickness: 1.0,
                        indent: 0.0,
                        endIndent: 0.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.textFieldModel4,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: 'Business or Trading Name',
                        labelPresent: true,
                        helper: '',
                        helperPresent: false,
                        leadingIcon: Icon(
                          Icons.help,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        leadingIconPresent: true,
                        trailingIconPresent: false,
                        hint: 'e.g. Juma Communications',
                        value: '',
                        onChange: '',
                        onSubmit: '',
                        variant: 'outlined',
                        error: false,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.textFieldModel5,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: 'Business Information',
                        labelPresent: true,
                        helper: '',
                        helperPresent: false,
                        leadingIcon: Icon(
                          Icons.description_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        leadingIconPresent: true,
                        trailingIconPresent: false,
                        hint: 'Briefly describe your services',
                        value: '',
                        onChange: '',
                        onSubmit: '',
                        variant: 'outlined',
                        error: false,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.textFieldModel6,
                      updateCallback: () => safeSetState(() {}),
                      child: TextFieldWidget(
                        label: 'M-Pesa Till Number',
                        labelPresent: true,
                        helper: 'Payments will be sent to this number',
                        helperPresent: true,
                        leadingIcon: Icon(
                          Icons.payments_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        leadingIconPresent: true,
                        trailingIconPresent: false,
                        hint: 'Enter your 6-7 digit Till number',
                        value: '',
                        onChange: '',
                        onSubmit: '',
                        variant: 'outlined',
                        error: false,
                      ),
                    ),
                    Container(
                      height: 16.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).info10,
                        borderRadius: BorderRadius.circular(12.0),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).info30,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.info_rounded,
                                color: FlutterFlowTheme.of(context).onInfo,
                                size: 18.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Your application will be reviewed by the Bingwa Market admin team. You will be notified via email once approved.',
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
                                        color:
                                            FlutterFlowTheme.of(context).onInfo,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodySmall
                                            .fontStyle,
                                        lineHeight: 1.4,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 12.0,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(BingwaDashboardWidget.routeName);
                      },
                      child: wrapWithModel(
                        model: _model.buttonModel1,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          iconPresent: false,
                          iconEndPresent: false,
                          content: 'Submit Application',
                          variant: 'primary',
                          size: 'large',
                          fullWidth: true,
                          loading: false,
                          disabled: false,
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(BrowseOffersWidget.routeName);
                      },
                      child: wrapWithModel(
                        model: _model.buttonModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: ButtonWidget(
                          iconPresent: false,
                          iconEndPresent: false,
                          content: 'Back to Browsing',
                          variant: 'ghost',
                          size: 'medium',
                          fullWidth: true,
                          loading: false,
                          disabled: false,
                        ),
                      ),
                    ),
                    Container(
                      height: 32.0,
                    ),
                  ].divide(SizedBox(height: 16.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
