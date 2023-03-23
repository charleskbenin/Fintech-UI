String formatAmount(String amount) {
  double value = double.parse(amount);
  String integerPart = value.toStringAsFixed(0);
  String decimalPart = value.toStringAsFixed(2).split('.')[1];
  return '${_addCommaSeparators(integerPart)}';
}

String _addCommaSeparators(String integerPart) {
  return integerPart.replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match match) => '${match[1]},',
  );
}

String obscureCreditCard(String cardNumber) {
  if (cardNumber.length < 4) {
    return cardNumber;
  } else {
    String lastFourDigits = cardNumber.substring(cardNumber.length - 4);
    String obscuredDigits = '';
    for (int i = 0; i < cardNumber.length - 4; i++) {
      obscuredDigits += ' *';
    }
    return '$obscuredDigits  $lastFourDigits';
  }
}
