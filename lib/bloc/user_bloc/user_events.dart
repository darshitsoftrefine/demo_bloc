abstract class UserEvents {}

class UserSubmittedEvent extends UserEvents {
  final int pageNumber;

  UserSubmittedEvent({required this.pageNumber});
}