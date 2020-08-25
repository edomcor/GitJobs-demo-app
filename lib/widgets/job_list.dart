import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/jobs.dart';
import '../widgets/job_item.dart';

class JobList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jobData = Provider.of<Jobs>(context);
    return ListView.builder(
      itemCount: jobData.jobs.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: jobData.jobs[index],
        child: JobItem(),
      ),
    );
  }
}
