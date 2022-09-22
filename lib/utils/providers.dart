

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_firebase_example/controllers/test_controller.dart';

final testRef = Provider((ref)=>FirebaseFirestore.instance.collection("Tests"));
final testController = Provider((ref)=>TestController(ref));