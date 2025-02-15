import 'package:flutter/material.dart';

class ShowTools {
  ShowTools._(this.context);

  final BuildContext context;

  static ShowTools of(BuildContext context) {
    return ShowTools._(context);
  }

  Future<void> showFullScreen({
    String? title,
    required Widget body,
  }) async {
    final result = await Navigator.of(context).push(
      DialogRoute(
        context: context,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: title != null ? Text(title) : null,
            forceMaterialTransparency: true,
          ),
          body: body,
        ),
      ),
    );
    return result;
  }

  Future<void> snackBar(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  /// Check if the context is still valid
  bool get mounted {
    return context.findRenderObject() != null && context.findRenderObject()!.attached;
  }
}
