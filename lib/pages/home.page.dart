import 'package:fingerprint_login/pages/datails.page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  initState() {
    super.initState();
    authenticate();
  }

  authenticate() async {
    if (await _isBiometricAvaliable()) {
      await _getListOfBiometricsType();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvaliable() async {
    try {
      bool isAvailable = await _localAuthentication.canCheckBiometrics;
      return isAvailable;
    } catch (err) {
      return false;
    }
  }

  Future<void> _getListOfBiometricsType() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
  }

  Future<void> _authenticateUser() async {
    bool isAuthenticated =
        await _localAuthentication.authenticateWithBiometrics(
            localizedReason: "Use a biometria para prosseguir",
            useErrorDialogs: true,
            stickyAuth: true);
    if (isAuthenticated) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailsPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faça login"),
      ),
      body: Container(
        child: Center(
          child: Text("Use a digital para prosseguir"),
        ),
      ),
    );
  }
}
