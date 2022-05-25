import 'package:deliveryapp/Bloc/MyLocation/mylocationmap_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MylocationmapBloc mylocationmapBloc;

  setUp(() {
    mylocationmapBloc = MylocationmapBloc();
  });
  tearDown(() {
    mylocationmapBloc.close();
  });

  group('LoggedIn', () {}
  );
}