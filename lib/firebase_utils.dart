import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/tasks.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: ((snapshot, options) =>
              Task.fromFireStore(snapshot.data()!)),
          toFirestore: (task, options) => task.tofireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollectionRef = getTasksCollection();
    DocumentReference<Task> taskDecRef = taskCollectionRef.doc();
    task.id = taskDecRef.id;
    return taskDecRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTaskInFireStore(Task task) async {
    try {
      var docRef = FirebaseFirestore.instance.collection('tasks').doc(task.id);

      // Check if the document exists
      var docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        await docRef.update(task.tofireStore());
      } else {
        throw Exception('Task not found');
      }
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }
}
