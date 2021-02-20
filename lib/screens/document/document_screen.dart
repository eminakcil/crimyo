import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

import 'package:crimyo/services/navigation_service.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({
    @required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: NavigationService().scaffoldKey = GlobalKey<ScaffoldState>(),
      body: SafeArea(
        child: EnhancedFutureBuilder(
          future: DefaultCacheManager().getSingleFile(url),
          rememberFutureResult: false,
          whenDone: (snapshotData) {
            return PDF.file(snapshotData);
          },
          whenNotDone: Center(child: CircularProgressIndicator()),
          whenError: (error) {
            return Center(child: Icon(Icons.error));
          },
        ),
      ),
    );
  }
}
