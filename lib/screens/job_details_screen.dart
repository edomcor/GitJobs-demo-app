import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../providers/jobs.dart';

class JobDetailsScreen extends StatelessWidget {
  static const routeName = "/job-detail";

  @override
  Widget build(BuildContext context) {
    final jobId = ModalRoute.of(context).settings.arguments as String;
    final job = Provider.of<Jobs>(context, listen: false).findById(jobId);

    final String jobDesc = job.description.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("Position Details"),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                job.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  "Location: ${job.location}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
                Text(
                  "Job type: ${job.type}",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownBody(data: jobDesc),
            )
          ],
        ),
      ),
    );
  }
}
