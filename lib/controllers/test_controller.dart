
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firebase_example/models/test_model.dart';
import 'package:riverpod_firebase_example/utils/providers.dart';

final fetchAllTest = FutureProvider<List<TestModel>>((ref)=>TestController(ref).fetchAllTest());
final fetchAllTestStream = StreamProvider<List<TestModel>>((ref)=>TestController(ref).fetchAllTestStream());

class TestController{
  final Ref ref;
  TestController(this.ref);

  Future<void> saveToFirestore(String text) async{
      TestModel t = TestModel(text: text, time: DateTime.now().toString());
      await ref.read(testRef).add(t.toMap());
  }

  Future<List<TestModel>> fetchAllTest()async {
    List<TestModel> models = [];
    await ref.read(testRef).get().then((value){
      value.docs.forEach((element) {
        models.add(TestModel.fromMap(element.data()));
      });
    });
    return models;
  }

  Stream<List<TestModel>> fetchAllTestStream()  {
    return ref.read(testRef).snapshots().map((value){
      List<TestModel> models = [];
      value.docs.forEach((element) {
        models.add(TestModel.fromMap(element.data()));
      });
      return models;
    });
  }


}