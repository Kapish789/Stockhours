import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_hours/models/fs_models.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Stream<MarketList> streamMarkets() {
    return _db.collection("constants").doc("markets").snapshots().map((snapshot) => MarketList.fromJson(snapshot.data()!));
  }
}
