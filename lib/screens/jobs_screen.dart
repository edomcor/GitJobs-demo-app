import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/job_list.dart';
import '../providers/jobs.dart';

class JobsScreen extends StatefulWidget {
  static const routeName = "/jobs";

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<Jobs>(context, listen: false).fetchJobs().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = _buildAppBar();

    return Scaffold(
      appBar: appBar,
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : JobList(),
    );
  }
}

Widget _buildAppBar() {
  return AppBar(
    title: Text("GitHub jobs"),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => null,
      )
    ],
  );
}

// not implemented yet
void _setFilters(BuildContext ctx) {
  showModalBottomSheet(
    backgroundColor: Colors.grey,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
    context: ctx,
    builder: (bCtx) {
      return null;
    },
  );
}
