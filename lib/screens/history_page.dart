import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: historyProvider.searchedPlates.isEmpty
          ? const Center(
              child: Text(
                'No search history available',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: historyProvider.searchedPlates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    historyProvider.searchedPlates[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
    );
  }
}

class HistoryProvider with ChangeNotifier {
  final List<String> _searchedPlates = [];

  List<String> get searchedPlates => _searchedPlates;

  void addPlate(String plate) {
    if (!_searchedPlates.contains(plate)) {
      _searchedPlates.add(plate);
      notifyListeners();
    }
  }
}
