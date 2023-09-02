import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/presentation/utils/custom_colors.dart';
import 'package:zoom_clone/services/firestore_methods.dart';

class HistoryMeetingScreen extends StatelessWidget {
  HistoryMeetingScreen({super.key});

  final FirestoreMethods firestoreMethods = FirestoreMethods();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreMethods.meetingHistory,
      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text('No Data Available'),
          );
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No Data Available'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var snap = snapshot.data!.docs[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: CustomColor.buttonColor,
                backgroundImage: NetworkImage(
                  snap['photoUrl'] ??
                      'https://w7.pngwing.com/pngs/312/283/png-transparent-man-s-face-avatar-computer-icons-user-profile-business-user-avatar-blue-face-heroes.png',
                ),
              ),
              title: Text(
                "Room Name: ${snap['meetingName']}",
              ),
              subtitle: Text(
                "Joined On: ${DateFormat.yMMMd().format(snap['createdAt'].toDate())}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              trailing: IconButton(
                onPressed: () async {
                  showAdaptiveDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog.adaptive(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure you want to Delete?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await deleteItem(id: snap['id']);
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
            );
          },
        );
      },
    );
  }

  deleteItem({required String id}) async {
    await FirestoreMethods().deleteSingleMeetInHistory(id: id);
  }
}
