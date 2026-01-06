class CartEvent {
  CartEvent();
}

class SendOrderEvent extends CartEvent {
  final String phone;
  final String shippingAddress;

  SendOrderEvent(this.phone, this.shippingAddress);
}
