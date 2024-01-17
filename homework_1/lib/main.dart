import 'package:flutter/material.dart';
import 'taxi_calculator.dart';
import 'orders.dart';
import 'library.dart';
import 'rpg_elements.dart';
import 'weather_forecast.dart';
import 'bank_operations.dart';
import 'news_fetcher.dart';

void main() {
  runApp(const MyApp());

  // Taxi
  calculateTaxiFare();

  // Order
  List<MenuItem> menu = [
    MenuItem('Pizza', 12.0),
    MenuItem('Burger', 8.0),
    MenuItem('Salad', 6.0),
  ];

  Order order = createOrder(menu, [2, 1, 3]);
  double total = calculateTotal(order, taxRate: 0.08, discountedItems: ['Pizza']);

  print('Order Details:');
  for (var orderItem in order.items) {
    print('${orderItem.menuItem.name} x${orderItem.quantity}: ${orderItem.menuItem.price * orderItem.quantity}');
  }
  print('Total: $total');

  // Library
  Library library = Library();

  library.addBook(1, '1984', 'George Orwell');
  library.addBook(2, 'To Kill a Mockingbird', 'Harper Lee');

  library.registerReader('Alice');
  library.registerReader('Bob');

  library.lendBook(1);
  library.returnBook(1);

  List<int> foundBooks = library.searchBook('George Orwell');
  print('Найденные книги по автору: $foundBooks');

  List<String> filteredReaders =
  library.filterReaders((reader) => reader.startsWith('A'));
  print('Отфильтрованные читатели: $filteredReaders');

  // RPG
  Mage mage = Mage(100, 15);
  Warrior warrior = Warrior(150, 20);
  Monster monster = Monster(200, 25);

  mage.castSpell();
  warrior.fly();
  warrior.attack();
  monster.attack();

  // Weather Forecast
  const apiKey = 'c151ed9059b8dde5a44e5dea09eaba48';
  const city = 'London,uk';

  fetchWeatherData(city, apiKey).then((data) {
    if (data['success']) {
      updateWeatherUI(data['data']);
    } else {
      print('Error: ${data['error']}');
    }
  });

  const refreshInterval = Duration(minutes: 10);
  Stream.periodic(refreshInterval).listen((_) {
    fetchWeatherData(city, apiKey).then((data) {
      if (data['success']) {
        updateWeatherUI(data['data']);
      } else {
        print('Error: ${data['error']}');
      }
    });
  });

  // Bank operations
  try {
    BankAccount account1 = BankAccount(1000);
    BankAccount account2 = BankAccount(500);

    print('Баланс на первом счете: ${account1.getBalance()} рублей');
    account1.deposit(200);
    account1.withdraw(300);
    account1.transfer(account2, 400);

    account2.withdraw(1000);
  } catch (e) {
    if (e is InsufficientFundsException) {
      print('Ошибка: ${e.errorMessage()}');
    } else {
      print('Произошла ошибка: $e');
    }
  }

  // News
  fetchNews();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
