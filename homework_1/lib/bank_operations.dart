class InsufficientFundsException implements Exception {
  String errorMessage() => 'Недостаточно средств на счете.';
}

class BankAccount {
  double balance;

  BankAccount(this.balance);

  void withdraw(double amount) {
    if (amount > balance) {
      throw InsufficientFundsException();
    } else {
      balance -= amount;
      print('Вы сняли $amount рублей. Баланс: $balance рублей');
    }
  }

  void deposit(double amount) {
    balance += amount;
    print('Вы внесли $amount рублей. Баланс: $balance рублей');
  }

  double getBalance() {
    return balance;
  }

  void transfer(BankAccount recipient, double amount) {
    if (amount > balance) {
      throw InsufficientFundsException();
    } else {
      balance -= amount;
      recipient.deposit(amount);
      print('Вы перевели $amount рублей на другой счет.');
      print('Ваш баланс: $balance рублей');
    }
  }
}