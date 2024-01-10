class MenuItem {
  final String name;
  final double price;

  MenuItem(this.name, this.price);
}

class OrderItem {
  final MenuItem menuItem;
  int quantity;

  OrderItem(this.menuItem, this.quantity);
}

class Order {
  final List<OrderItem> items = [];
}

Order createOrder(List<MenuItem> menu, List<int> quantities) {
  if (menu.length != quantities.length) {
    throw Exception('Menu length should match quantities length');
  }

  Order order = Order();
  for (int i = 0; i < menu.length; i++) {
    order.items.add(OrderItem(menu[i], quantities[i]));
  }

  return order;
}

double calculateTotal(Order order, {double taxRate = 0.1, List<String> discountedItems = const []}) {
  double subtotal = 0;
  for (var orderItem in order.items) {
    double itemTotal = orderItem.quantity * orderItem.menuItem.price;

    if (discountedItems.contains(orderItem.menuItem.name)) {
      itemTotal *= 0.8;
    }

    subtotal += itemTotal;
  }

  double tax = subtotal * taxRate;
  double total = subtotal + tax;
  return total;
}