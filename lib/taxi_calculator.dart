void calculateTaxiFare() {
  double tariff1 = 250;
  double tariff2 = 200;
  double tariff3 = 150;

  double econCoeff = 1;
  double standardCoeff = 2;
  double premiumCoeff = 3;

  double totalDistance = 25;
  double totalCost = 0;
  double currentDistance = 0;

  while (currentDistance < totalDistance) {
    if (currentDistance + 1 <= 10) {
      totalCost += tariff1 * econCoeff;
    } else if (currentDistance + 1 > 10 && currentDistance + 1 <= 20) {
      totalCost += tariff2 * standardCoeff;
    } else {
      totalCost += tariff3 * premiumCoeff;
    }
    currentDistance++;
  }

  print('Пройденное расстояние: ${totalDistance} км');
  print('Итоговая стоимость поездки: ${totalCost} тенге');
}