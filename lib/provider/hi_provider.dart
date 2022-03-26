import 'package:blibli/provider/theme_provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> topProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider())
];
