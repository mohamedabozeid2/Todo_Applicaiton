import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference getTodoCollectionReference(){
  CollectionReference todoCollection = FirebaseFirestore.instance.collection('todo');
  return todoCollection;
}