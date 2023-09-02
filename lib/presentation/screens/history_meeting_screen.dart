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
            );
          },
        );
      },
    );
  }
}
