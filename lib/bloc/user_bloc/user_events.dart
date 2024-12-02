abstract class UserEvents {}

class UserSubmittingEvent extends UserEvents {}

class UserSubmittedEvent extends UserEvents {
  final int pageNumber;

  UserSubmittedEvent({required this.pageNumber});
}