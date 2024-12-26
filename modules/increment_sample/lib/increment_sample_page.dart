import 'package:core/core.dart';
import 'package:increment_sample/l10n/gen/l10n.dart';

class IncrementSamplePage extends StatefulWidget {
  const IncrementSamplePage({super.key});

  @override
  State<IncrementSamplePage> createState() => _IncrementSamplePageState();
}

class _IncrementSamplePageState extends State<IncrementSamplePage> {
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
        title: Text(L10n.of(context).title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            L10n.of(context).message,
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}