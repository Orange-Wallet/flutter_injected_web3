<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

This is wrapper around slightly modified version of Trust Wallet's Web3 Injection.

Note: Its still early draft, we will try to update it whenever necessary or whenever we get time, so PRs are most welcome.

## Features

In most dapps you will se option of "Injected web3" if nothing like this comes up you can select Metamask, Trust wallet or any other wallet that injects web3.

## Getting started
If you are using flutter_inappwebview, use it directly from the Injected web3 package itself.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```
class MyApp extends StatelessWidget {
  String rpc = "https://rpc.ankr.com/polygon";
  int chainId = 137;

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: InjectedWebview(
            addEthereumChain: changeNetwork,
            requestAccounts: getAccount,
            signTransaction: signTransaction,
            signPersonalMessage: signPersonelMessage,
            isDebug: true,
            initialUrlRequest:
                URLRequest(url: Uri.parse('https://opensea.io/')),
            chainId: chainId,
            rpc: rpc),
      ),
    );
  }

  Future<String> changeNetwork(InAppWebViewController controller,
      JsAddEthereumChain data, int chainId) async {
    try {
      rpc = "https://rpc.ankr.com/eth";
      chainId = int.parse(data.chainId!);
    } catch (e) {
      debugPrint("$e");
    }
    return rpc;
  }

  Future<IncomingAccountsModel> getAccount(
      InAppWebViewController _, String ___, int __) async {
    Credentials fromHex = EthPrivateKey.fromHex(
        "Private key here");
    final address = await fromHex.extractAddress();
    return IncomingAccountsModel(
        address: address.toString(), chainId: chainId, rpcUrl: rpc);
  }

  Future<String> signTransaction(
      InAppWebViewController _, JsTransactionObject data, int chainId) async {
    return "0x45fb0060681bf5d8ea675ab0b3f76aa15c84b172f2fb3191b7a8ceb1e6a7f372";
  }

  Future<String> signPersonelMessage(
      InAppWebViewController _, String data, int chainId) async {
    try {
      Credentials fromHex = EthPrivateKey.fromHex(
          "Private key here");
      final sig = await fromHex.signPersonalMessage(hexToBytes(data));

      debugPrint("SignedTx ${sig}");
      return bytesToHex(sig, include0x: true);
    } catch (e) {
      debugPrint("$e");
    }
    return "";
  }
}

```

## Additional information
Special thanks to Trust Wallet for their implmentaion of Web3 Injection