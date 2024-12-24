import 'package:flutter/material.dart';
import 'package:provider_product/invoice.dart';

class InvoiceModel extends ChangeNotifier {
  List<Invoice> invoices = [];
  int _selectedIndex = -1;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
  }

  Invoice getLast() {
    return invoices.last;
  }

  bool isEmpty() {
    return invoices.isEmpty;
  }

  addInvoice(Invoice inv) {
    invoices.add(inv);
    notifyListeners();
  }

  int getSize() {
    return invoices.length;
  }

  Invoice getInvoice(int index) {
    return invoices[index];
  }

  Invoice getSelectedInvoice() {
    return invoices[selectedIndex];
  }

  removeInvoice() {
    invoices.removeAt(selectedIndex);
    notifyListeners();
  }
}
