import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String bookingTable = "booking";
  String profileTable = "profile";

  updateStatus(String id, String status) {
    print(id);
    final DocumentReference docRef = firestore.collection(bookingTable).doc(id);
    docRef.update(
      {
        "bookingStatus": status,
      },
    );
  }
}
