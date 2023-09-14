import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String bookingTable = "booking";
  String profileTable = "profile";

  updateStatus(String bookingId, String status) async {
    // final DocumentReference docRef = firestore.collection(bookingTable).where();

    QuerySnapshot querySnapshot = await firestore
        .collection(bookingTable) // Replace with your collection name
        .where('bookingId', isEqualTo: bookingId)
        .limit(1) // Replace with your field and condition
        .get();
    querySnapshot.docs.first.reference.update(
      {
        "bookingStatus": status,
      },
    );
  }
}
