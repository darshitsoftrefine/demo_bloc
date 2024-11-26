abstract class UserEvents {}

class UserSubmittedEvent extends UserEvents {
  int pageNumber;

  UserSubmittedEvent({required this.pageNumber});
}