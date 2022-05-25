
import 'package:bloc_test/bloc_test.dart';
import 'package:deliveryapp/Bloc/Auth/auth_bloc.dart';
import 'package:deliveryapp/Services/userController.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserControllerImpl extends Mock implements UserController{}

void main(){
  late AuthBloc authbloc;
  late MockUserControllerImpl mockUserController;

  setUp((){
    mockUserController = MockUserControllerImpl();
    authbloc =AuthBloc();
  });
  tearDown((){
    authbloc.close();
  });


  group('LoggedIn', ()
  {
    test('emits when login is unsuccessful', () async {
      const  result = "the provided credentials are incorrect";
      when(mockUserController.loginController("billy@deliveryapp.com", "testtest1")).thenAnswer((_) async { return result;});
      final res = mockUserController.loginController("billy@deliveryapp.com", "testtest1");
      expect(await res, 'the provided credentials are incorrect');
    });
    test('emits when login is successful', () async {
      const  result = null;
      when(mockUserController.loginController("billy@deliveryapp.com", "testtest")).thenAnswer((_) async { return result;});
      final res = mockUserController.loginController("billy@deliveryapp.com", "testtest");
      expect(await res, result);
    });
    test("Auth bloc should have Initial state", () {
      expect(authbloc.state.runtimeType, AuthInitial);
    });

    const  result = "The provided credentials are incorrect.";

     blocTest ("Authentication FailureState",
       build: ()=>authbloc,
       act: (Bloc) => authbloc.add(const LoginEvent("billy@deliveryapp.com","testtest1" )),
       wait: const Duration(milliseconds: 1000),
       expect:()=> [LoadingAuthState(), FailureAuthState(result)],
    );
    blocTest("Authentication SuccessState",
      build: ()=>authbloc,
      act: (Bloc) => authbloc.add(const LoginEvent("billy@deliveryapp.com","testtest" )),
      wait: const Duration(milliseconds: 1000),
      expect:()=> [
        LoadingAuthState(),
        SuccessAuthState()
      ],
    );



  });}