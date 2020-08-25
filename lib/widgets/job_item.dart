import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/auth.dart';
import '../providers/job.dart';

class JobItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final job = Provider.of<Job>(context, listen: true);
    final authData = Provider.of<Auth>(context, listen: true);
    final bool isSaved = (job.isSaved == false || job.isSaved == null);
    DateTime date =
        DateFormat("EEE MMM d").parse(job.createdAt.substring(0, 10));
    var timeAgo = Jiffy([2020, date.month, date.day]).fromNow();
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              "/job-detail",
              arguments: job.id,
            );
          },
          child: Card(
            color: isSaved ? Colors.white : Colors.orange[100],
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: FadeInImage(
                      width: 100,
                      height: 100,
                      placeholder: AssetImage("assets/images/placeholder.jpg"),
                      image: job.companyLogo != null
                          ? NetworkImage(job.companyLogo)
                          : AssetImage("assets/images/placeholder.jpg"),
                    ),
                  ),
                ),
                title: Text(
                  job.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  "Location: ${job.location}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Column(
                  children: [
                    Text("${job.type}"),
                    // Text("${job.createdAt.substring(0, 10)}")
                    Text(
                      "$timeAgo",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        IconSlideAction(
          caption: isSaved ? 'Archive' : "Remove",
          color: Colors.blue,
          icon: isSaved ? Icons.archive : Icons.delete,
          onTap: () {
            Provider.of<Job>(context, listen: false)
                .toggleSavedStatus(authData.token, authData.userId);
          },
        ),
      ],
      secondaryActions: [
        IconSlideAction(
          caption: isSaved ? 'Archive' : "Remove",
          color: Colors.blue,
          icon: isSaved ? Icons.archive : Icons.delete,
          onTap: () {
            Provider.of<Job>(context, listen: false)
                .toggleSavedStatus(authData.token, authData.userId);
          },
        ),
      ],
    );
  }
}

//     Dismissible(
//       key: ValueKey(job.id),
//       direction: DismissDirection.startToEnd,
//       confirmDismiss: (direction) {
//         return showDialog(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: Text("Confirm"),
//             content: Text("Do you want to save this job?"),
//             actions: [
//               FlatButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop(true);
//                 },
//                 child: Text("No"),
//               ),
//               FlatButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop(false);
//                 },
//                 child: Text("Yes"),
//               ),
//             ],
//           ),
//         );
//       },
//       onDismissed: (direction) {
//         Provider.of<Job>(context, listen: false)
//             .toggleSavedStatus(authData.token, authData.userId);
//       },
//       background: Container(
//         color: Theme.of(context).accentColor,
//         child: Icon(
//           Icons.save,
//           color: Colors.white,
//           size: 40,
//         ),
//         alignment: Alignment.centerLeft,
//         padding: EdgeInsets.only(left: 20),
//         margin: EdgeInsets.symmetric(
//           horizontal: 15,
//           vertical: 4,
//         ),
//       ),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pushNamed(
//             "/job-detail",
//             arguments: job.id,
//           );
//         },
//         child: Card(
//           margin: EdgeInsets.symmetric(
//             horizontal: 15,
//             vertical: 4,
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: ListTile(
//               leading: Padding(
//                 padding: EdgeInsets.all(5),
//                 child: FittedBox(
//                   child: FadeInImage(
//                     width: 100,
//                     height: 100,
//                     placeholder: AssetImage("assets/images/placeholder.jpg"),
//                     image: job.companyLogo != null
//                         ? NetworkImage(job.companyLogo)
//                         : AssetImage("assets/images/placeholder.jpg"),
//                   ),
//                 ),
//               ),
//               title: Text(
//                 job.title,
//                 style: Theme.of(context).textTheme.bodyText1,
//               ),
//               subtitle: Text(
//                 "Location: ${job.location}",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               trailing: Column(
//                 children: [
//                   Text("${job.type}"),
//                   // Text("${job.createdAt.substring(0, 10)}")
//                   Text(
//                     "$timeAgo",
//                     style: TextStyle(fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
