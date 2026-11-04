import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'verified_badge_model.dart';
export 'verified_badge_model.dart';

class VerifiedBadgeWidget extends StatefulWidget {
  const VerifiedBadgeWidget({
    super.key,
    bool? verified,
  }) : this.verified = verified ?? true;

  final bool verified;

  @override
  State<VerifiedBadgeWidget> createState() => _VerifiedBadgeWidgetState();
}

class _VerifiedBadgeWidgetState extends State<VerifiedBadgeWidget> {
  late VerifiedBadgeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VerifiedBadgeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: valueOrDefault<bool>(
        widget!.verified,
        true,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).success10,
          borderRadius: BorderRadius.circular(9999.0),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: FlutterFlowTheme.of(context).success,
                  size: 14.0,
                ),
                Text(
                  'Verified',
                  style: FlutterFlowTheme.of(context).labelSmall.override(
                        font: GoogleFonts.spaceGrotesk(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).success,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelSmall.fontStyle,
                        lineHeight: 1.2,
                      ),
                ),
              ].divide(SizedBox(width: 4.0)),
            ),
          ),
        ),
      ),
    );
  }
}
