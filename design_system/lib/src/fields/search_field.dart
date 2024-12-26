import '../../design_system.dart';

class SearchField extends StatelessWidget {
  final String hintText;

  const SearchField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}