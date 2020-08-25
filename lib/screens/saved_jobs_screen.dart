import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/saved_jobs.dart';
import '../widgets/app_drawer.dart';

class SavedJobsScreen extends StatefulWidget {
  static const routeName = "/saved-jobs";

  @override
  _SavedJobsScreenState createState() => _SavedJobsScreenState();
}

class _SavedJobsScreenState extends State<SavedJobsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<SavedJobs>(context, listen: false).fetchSavedJobs().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text("Not yet implemented"),
            ),
    );
  }
}
