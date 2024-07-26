import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/NotificationProvider.dart';
import '../models/Notification.dart';

class NotificationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Notificaciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          notificationProvider.notifications.isEmpty
              ? Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Sin notificaciones',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : Container(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationProvider.notifications.length,
                    itemBuilder: (context, index) {
                      final notification =
                          notificationProvider.notifications[index];
                      return ListTile(
                        leading: Icon(Icons.notification_important,
                            color: Colors.red),
                        title: Text(
                          notification.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(notification.message),
                        trailing: Icon(Icons.arrow_forward, color: Colors.red),
                        onTap: () {
                          Navigator.of(context)
                              .pop(); // Cerrar el cuadro de diálogo primero
                          notification.onTap(context); // Pasar context aquí
                          notificationProvider.removeNotification(notification);
                        },
                      );
                    },
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                notificationProvider.clearNotifications();
                Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
              child: Text('Borrar todas las notificaciones'),
            ),
          ),
        ],
      ),
    );
  }
}
