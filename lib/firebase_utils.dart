import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/tasks.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFireStore(snapshot.data()!)),
          toFirestore: (task, options) => task.tofireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task, String uId) {
    var taskCollectionRef = getTasksCollection(uId);
    DocumentReference<Task> taskDecRef = taskCollectionRef.doc();
    task.id = taskDecRef.id;
    return taskDecRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateTaskInFireStore(Task task, String uId) async {
    try {
      var taskCollectionRef = getTasksCollection(uId);
      var docRef = taskCollectionRef.doc(task.id);

      // Check if the document exists
      var docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        await docRef.update(task.tofireStore());
      } else {
        throw Exception('Task not found');
      }
    } catch (e) {
      print('Error updating task: $e');
      throw Exception('Failed to update task: $e');
    }
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, options) =>
                MyUser.fromFireStore(snapshot.data())),
            toFirestore: (myUser, option) => myUser.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUserCollection().doc(uId).get();
    return querySnapshot.data();
  }
}
