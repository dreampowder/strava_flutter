// Test

abstract class Toto {
  void getToto() {
    print('getToto');
  }

  void sendToto() {
    print('sendToto');
  }
}


abstract class Titi {
  void getTiti() {
    print('getTiti');
  }

  void sendTiti() {
    print('sendTiti');
  }
}


class Grand with Toto, Titi {

String tokenito = 'ghghjg';


  getToto();

  sendTiti();



}


