// ignore_for_file: constant_identifier_names

enum AuthState {
  LOGIN,
  LOADING,
  SUCCESS,
  ERROR;
}

enum AuthChengePage {
  LOGIN(inView: 'LOGIN'),
  REGISTER(inView: 'SING UP');

  final String inView;

  const AuthChengePage({required this.inView});
}
