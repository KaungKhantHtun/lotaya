import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String bookingTable = "booking";
  String profileTable = "profile";

  updateStatus(String bookingId, String status) async {
    print("booking Id: $bookingId");
    await firestore.collection(bookingTable).doc(bookingId).update(
      {
        "bookingStatus": status,
      },
    );
  }
}
