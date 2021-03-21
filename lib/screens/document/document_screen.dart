import 'package:flutter/material.dart';

import 'package:enhanced_future_builder/enhanced_future_builder.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_flutter/pdf_flutter.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({
    @required this.url,
    this.title,
  });

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title ?? ''),
        ),
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
