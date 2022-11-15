import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter_injected_web3/src/js_callback_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/gestures/recognizer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InjectedWebview extends StatefulWidget implements WebView {
  /// `gestureRecognizers` specifies which gestures should be consumed by the WebView.
  /// It is possible for other gesture recognizers to be competing with the web view on pointer
  /// events, e.g if the web view is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The web view will claim gestures that are recognized by any of the
  /// recognizers on this list.
  /// When `gestureRecognizers` is empty or null, the web view will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///The window id of a [CreateWindowAction.windowId].
  @override
  final int? windowId;
  final bool isDebug;
  int chainId;
  String rpc;
  bool initialized = false;
  String? currentURL;
  InjectedWebview({
    required this.chainId,
    required this.rpc,
    Key? key,
    this.windowId,
    this.initialUrlRequest,
    this.initialFile,
    this.initialData,
    this.initialOptions,
    this.initialUserScripts,
    this.pullToRefreshController,
    this.implementation = WebViewImplementation.NATIVE,
    this.contextMenu,
    this.onWebViewCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.onLoadError,
    this.onLoadHttpError,
    this.onConsoleMessage,
    this.onProgressChanged,
    this.shouldOverrideUrlLoading,
    this.onLoadResource,
    this.onScrollChanged,
    @Deprecated('Use `onDownloadStartRequest` instead') this.onDownloadStart,
    this.onDownloadStartRequest,
    this.onLoadResourceCustomScheme,
    this.onCreateWindow,
    this.onCloseWindow,
    this.onJsAlert,
    this.onJsConfirm,
    this.onJsPrompt,
    this.onReceivedHttpAuthRequest,
    this.onReceivedServerTrustAuthRequest,
    this.onReceivedClientCertRequest,
    this.onFindResultReceived,
    this.shouldInterceptAjaxRequest,
    this.onAjaxReadyStateChange,
    this.onAjaxProgress,
    this.shouldInterceptFetchRequest,
    this.onUpdateVisitedHistory,
    this.onPrint,
    this.onLongPressHitTestResult,
    this.onEnterFullscreen,
    this.onExitFullscreen,
    this.onPageCommitVisible,
    this.onTitleChanged,
    this.onWindowFocus,
    this.onWindowBlur,
    this.onOverScrolled,
    this.onZoomScaleChanged,
    this.androidOnSafeBrowsingHit,
    this.androidOnPermissionRequest,
    this.androidOnGeolocationPermissionsShowPrompt,
    this.androidOnGeolocationPermissionsHidePrompt,
    this.androidShouldInterceptRequest,
    this.androidOnRenderProcessGone,
    this.androidOnRenderProcessResponsive,
    this.androidOnRenderProcessUnresponsive,
    this.androidOnFormResubmission,
    @Deprecated('Use `onZoomScaleChanged` instead') this.androidOnScaleChanged,
    this.androidOnReceivedIcon,
    this.androidOnReceivedTouchIconUrl,
    this.androidOnJsBeforeUnload,
    this.androidOnReceivedLoginRequest,
    this.iosOnWebContentProcessDidTerminate,
    this.iosOnDidReceiveServerRedirectForProvisionalNavigation,
    this.iosOnNavigationResponse,
    this.iosShouldAllowDeprecatedTLS,
    this.gestureRecognizers,
    this.signTransaction,
    this.signPersonalMessage,
    this.signMessage,
    this.signTypedMessage,
    this.ecRecover,
    this.requestAccounts,
    this.watchAsset,
    this.addEthereumChain,
    this.isDebug = false,
  }) : super();

  @override
  // ignore: library_private_types_in_public_api
  _InjectedWebviewState createState() => _InjectedWebviewState();

  @override
  final void Function(InAppWebViewController controller)?
      androidOnGeolocationPermissionsHidePrompt;

  @override
  final Future<GeolocationPermissionShowPromptResponse?> Function(
          InAppWebViewController controller, String origin)?
      androidOnGeolocationPermissionsShowPrompt;

  @override
  final Future<PermissionRequestResponse?> Function(
      InAppWebViewController controller,
      String origin,
      List<String> resources)? androidOnPermissionRequest;

  @override
  final Future<SafeBrowsingResponse?> Function(
      InAppWebViewController controller,
      Uri url,
      SafeBrowsingThreat? threatType)? androidOnSafeBrowsingHit;

  @override
  final InAppWebViewInitialData? initialData;

  @override
  final String? initialFile;

  @override
  final InAppWebViewGroupOptions? initialOptions;

  @override
  final URLRequest? initialUrlRequest;

  @override
  final WebViewImplementation implementation;

  @override
  final UnmodifiableListView<UserScript>? initialUserScripts;

  @override
  final PullToRefreshController? pullToRefreshController;

  @override
  final ContextMenu? contextMenu;

  @override
  final void Function(InAppWebViewController controller, Uri? url)?
      onPageCommitVisible;

  @override
  final void Function(InAppWebViewController controller, String? title)?
      onTitleChanged;

  @override
  final void Function(InAppWebViewController controller)?
      iosOnDidReceiveServerRedirectForProvisionalNavigation;

  @override
  final void Function(InAppWebViewController controller)?
      iosOnWebContentProcessDidTerminate;

  @override
  final Future<IOSNavigationResponseAction?> Function(
      InAppWebViewController controller,
      IOSWKNavigationResponse navigationResponse)? iosOnNavigationResponse;

  @override
  final Future<IOSShouldAllowDeprecatedTLSAction?> Function(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? iosShouldAllowDeprecatedTLS;

  @override
  final Future<AjaxRequestAction> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)?
      onAjaxProgress;

  @override
  final Future<AjaxRequestAction?> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)?
      onAjaxReadyStateChange;

  @override
  final void Function(
          InAppWebViewController controller, ConsoleMessage consoleMessage)?
      onConsoleMessage;

  @override
  final Future<bool?> Function(InAppWebViewController controller,
      CreateWindowAction createWindowAction)? onCreateWindow;

  @override
  final void Function(InAppWebViewController controller)? onCloseWindow;

  @override
  final void Function(InAppWebViewController controller)? onWindowFocus;

  @override
  final void Function(InAppWebViewController controller)? onWindowBlur;

  @override
  final void Function(InAppWebViewController controller, Uint8List icon)?
      androidOnReceivedIcon;

  @override
  final void Function(
          InAppWebViewController controller, Uri url, bool precomposed)?
      androidOnReceivedTouchIconUrl;

  ///Use [onDownloadStartRequest] instead
  @Deprecated('Use `onDownloadStartRequest` instead')
  @override
  final void Function(InAppWebViewController controller, Uri url)?
      onDownloadStart;

  @override
  final void Function(InAppWebViewController controller,
      DownloadStartRequest downloadStartRequest)? onDownloadStartRequest;

  @override
  final void Function(InAppWebViewController controller, int activeMatchOrdinal,
      int numberOfMatches, bool isDoneCounting)? onFindResultReceived;

  @override
  final Future<JsAlertResponse?> Function(
          InAppWebViewController controller, JsAlertRequest jsAlertRequest)?
      onJsAlert;

  @override
  final Future<JsConfirmResponse?> Function(
          InAppWebViewController controller, JsConfirmRequest jsConfirmRequest)?
      onJsConfirm;

  @override
  final Future<JsPromptResponse?> Function(
          InAppWebViewController controller, JsPromptRequest jsPromptRequest)?
      onJsPrompt;

  @override
  final void Function(InAppWebViewController controller, Uri? url, int code,
      String message)? onLoadError;

  @override
  final void Function(InAppWebViewController controller, Uri? url,
      int statusCode, String description)? onLoadHttpError;

  @override
  final void Function(
          InAppWebViewController controller, LoadedResource resource)?
      onLoadResource;

  @override
  final Future<CustomSchemeResponse?> Function(
      InAppWebViewController controller, Uri url)? onLoadResourceCustomScheme;

  @override
  final void Function(InAppWebViewController controller, Uri? url)? onLoadStart;

  @override
  final void Function(InAppWebViewController controller, Uri? url)? onLoadStop;

  @override
  final void Function(InAppWebViewController controller,
      InAppWebViewHitTestResult hitTestResult)? onLongPressHitTestResult;

  @override
  final void Function(InAppWebViewController controller, Uri? url)? onPrint;

  @override
  final void Function(InAppWebViewController controller, int progress)?
      onProgressChanged;

  @override
  final Future<ClientCertResponse?> Function(InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedClientCertRequest;

  @override
  final Future<HttpAuthResponse?> Function(InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedHttpAuthRequest;

  @override
  final Future<ServerTrustAuthResponse?> Function(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedServerTrustAuthRequest;

  @override
  final void Function(InAppWebViewController controller, int x, int y)?
      onScrollChanged;

  @override
  final void Function(
          InAppWebViewController controller, Uri? url, bool? androidIsReload)?
      onUpdateVisitedHistory;

  @override
  final void Function(InAppWebViewController controller)? onWebViewCreated;

  @override
  final Future<AjaxRequest?> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)?
      shouldInterceptAjaxRequest;

  @override
  final Future<FetchRequest?> Function(
          InAppWebViewController controller, FetchRequest fetchRequest)?
      shouldInterceptFetchRequest;

  @override
  final Future<NavigationActionPolicy?> Function(
          InAppWebViewController controller, NavigationAction navigationAction)?
      shouldOverrideUrlLoading;

  @override
  final void Function(InAppWebViewController controller)? onEnterFullscreen;

  @override
  final void Function(InAppWebViewController controller)? onExitFullscreen;

  @override
  final void Function(InAppWebViewController controller, int x, int y,
      bool clampedX, bool clampedY)? onOverScrolled;

  @override
  final void Function(
          InAppWebViewController controller, double oldScale, double newScale)?
      onZoomScaleChanged;

  @override
  final Future<WebResourceResponse?> Function(
          InAppWebViewController controller, WebResourceRequest request)?
      androidShouldInterceptRequest;

  @override
  final Future<WebViewRenderProcessAction?> Function(
          InAppWebViewController controller, Uri? url)?
      androidOnRenderProcessUnresponsive;

  @override
  final Future<WebViewRenderProcessAction?> Function(
          InAppWebViewController controller, Uri? url)?
      androidOnRenderProcessResponsive;

  @override
  final void Function(
          InAppWebViewController controller, RenderProcessGoneDetail detail)?
      androidOnRenderProcessGone;

  @override
  final Future<FormResubmissionAction?> Function(
      InAppWebViewController controller, Uri? url)? androidOnFormResubmission;

  ///Use [onZoomScaleChanged] instead.
  @Deprecated('Use `onZoomScaleChanged` instead')
  @override
  final void Function(
          InAppWebViewController controller, double oldScale, double newScale)?
      androidOnScaleChanged;

  @override
  final Future<JsBeforeUnloadResponse?> Function(
      InAppWebViewController controller,
      JsBeforeUnloadRequest jsBeforeUnloadRequest)? androidOnJsBeforeUnload;

  @override
  final void Function(
          InAppWebViewController controller, LoginRequest loginRequest)?
      androidOnReceivedLoginRequest;
  final Future<String> Function(InAppWebViewController controller,
      JsTransactionObject data, int chainId)? signTransaction;
  final Future<String> Function(
          InAppWebViewController controller, String data, int chainId)?
      signPersonalMessage;
  final Future<String> Function(
      InAppWebViewController controller, String data, int chainId)? signMessage;
  final Future<String> Function(InAppWebViewController controller,
      JsEthSignTypedData data, int chainId)? signTypedMessage;
  final Future<String> Function(InAppWebViewController controller,
      JsEcRecoverObject data, int chainId)? ecRecover;
  final Future<IncomingAccountsModel> Function(
          InAppWebViewController controller, String data, int chainId)?
      requestAccounts;
  final Future<String> Function(
          InAppWebViewController controller, JsWatchAsset data, int chainId)?
      watchAsset;

  final Future<String> Function(InAppWebViewController controller,
      JsAddEthereumChain data, int chainId)? addEthereumChain;
}

class _InjectedWebviewState extends State<InjectedWebview> {
  String address = "";
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      windowId: widget.windowId,
      initialUrlRequest: widget.initialUrlRequest,
      initialFile: widget.initialFile,
      initialData: widget.initialData,
      initialOptions: widget.initialOptions,
      initialUserScripts: widget.initialUserScripts,
      pullToRefreshController: widget.pullToRefreshController,
      implementation: widget.implementation,
      contextMenu: widget.contextMenu,
      onWebViewCreated: widget.onWebViewCreated,
      onLoadStart: (controller, uri) async {
        print("Load start: ${await controller.getProgress()}");
        _initWeb3(controller, true);
        widget.initialized = true;
        widget.onLoadStart?.call(controller, uri);
      },
      onLoadStop: (controller, uri) async {
        _initWeb3(controller, true);
        print("Load stop: ${await controller.getProgress()}");
        widget.onLoadStop?.call(controller, uri);
      },
      onLoadError: widget.onLoadError,
      onLoadHttpError: widget.onLoadHttpError,
      onConsoleMessage: (
        controller,
        consoleMessage,
      ) {
        if (widget.isDebug) {
          print("Console Message: ${consoleMessage.message}");
        }
        widget.onConsoleMessage?.call(
          controller,
          consoleMessage,
        );
      },
      onProgressChanged: (controller, progress) async {
        print("Progress change: ${await controller.getProgress()}");

        _initWeb3(controller, true);
        widget.onProgressChanged?.call(controller, progress);
      },
      shouldOverrideUrlLoading: widget.shouldOverrideUrlLoading,
      onLoadResource: widget.onLoadResource,
      onScrollChanged: widget.onScrollChanged,
      onDownloadStart: widget.onDownloadStart,
      onDownloadStartRequest: widget.onDownloadStartRequest,
      onLoadResourceCustomScheme: widget.onLoadResourceCustomScheme,
      onCreateWindow: widget.onCreateWindow,
      onCloseWindow: widget.onCloseWindow,
      onJsAlert: widget.onJsAlert,
      onJsConfirm: widget.onJsConfirm,
      onJsPrompt: widget.onJsPrompt,
      onReceivedHttpAuthRequest: widget.onReceivedHttpAuthRequest,
      onReceivedServerTrustAuthRequest: widget.onReceivedServerTrustAuthRequest,
      onReceivedClientCertRequest: widget.onReceivedClientCertRequest,
      onFindResultReceived: widget.onFindResultReceived,
      shouldInterceptAjaxRequest: widget.shouldInterceptAjaxRequest,
      onAjaxReadyStateChange: widget.onAjaxReadyStateChange,
      onAjaxProgress: widget.onAjaxProgress,
      shouldInterceptFetchRequest: widget.shouldInterceptFetchRequest,
      onUpdateVisitedHistory: widget.onUpdateVisitedHistory,
      onPrint: widget.onPrint,
      onLongPressHitTestResult: widget.onLongPressHitTestResult,
      onEnterFullscreen: widget.onEnterFullscreen,
      onExitFullscreen: widget.onExitFullscreen,
      onPageCommitVisible: widget.onPageCommitVisible,
      onTitleChanged: widget.onTitleChanged,
      onWindowFocus: widget.onWindowFocus,
      onWindowBlur: widget.onWindowBlur,
      onOverScrolled: widget.onOverScrolled,
      onZoomScaleChanged: widget.onZoomScaleChanged,
      androidOnSafeBrowsingHit: widget.androidOnSafeBrowsingHit,
      androidOnPermissionRequest: widget.androidOnPermissionRequest,
      androidOnGeolocationPermissionsShowPrompt:
          widget.androidOnGeolocationPermissionsShowPrompt,
      androidOnGeolocationPermissionsHidePrompt:
          widget.androidOnGeolocationPermissionsHidePrompt,
      androidShouldInterceptRequest: widget.androidShouldInterceptRequest,
      androidOnRenderProcessGone: widget.androidOnRenderProcessGone,
      androidOnRenderProcessResponsive: widget.androidOnRenderProcessResponsive,
      androidOnRenderProcessUnresponsive:
          widget.androidOnRenderProcessUnresponsive,
      androidOnFormResubmission: widget.androidOnFormResubmission,
      androidOnScaleChanged: widget.androidOnScaleChanged,
      androidOnReceivedIcon: widget.androidOnReceivedIcon,
      androidOnReceivedTouchIconUrl: widget.androidOnReceivedTouchIconUrl,
      androidOnJsBeforeUnload: widget.androidOnJsBeforeUnload,
      androidOnReceivedLoginRequest: widget.androidOnReceivedLoginRequest,
      iosOnWebContentProcessDidTerminate:
          widget.iosOnWebContentProcessDidTerminate,
      iosOnDidReceiveServerRedirectForProvisionalNavigation:
          widget.iosOnDidReceiveServerRedirectForProvisionalNavigation,
      iosOnNavigationResponse: widget.iosOnNavigationResponse,
      iosShouldAllowDeprecatedTLS: widget.iosShouldAllowDeprecatedTLS,
      gestureRecognizers: widget.gestureRecognizers,
    );
  }

  _initWeb3(InAppWebViewController controller, bool reInit) async {
    await controller.injectJavascriptFileFromAsset(
        assetFilePath: "packages/flutter_injected_web3/assets/provider.min.js");

    String initJs = reInit
        ? _loadReInt(widget.chainId, widget.rpc, address)
        : _loadInitJs(widget.chainId, widget.rpc);
    debugPrint("RPC: ${widget.rpc}");
    await controller.evaluateJavascript(source: initJs);
    if (controller.javaScriptHandlersMap["OrangeHandler"] == null) {
      controller.addJavaScriptHandler(
          handlerName: "OrangeHandler",
          callback: (callback) async {
            final jsData = JsCallbackModel.fromJson(callback[0]);

            debugPrint("callBack: $callback");
            switch (jsData.name) {
              case "signTransaction":
                {
                  try {
                    final data =
                        JsTransactionObject.fromJson(jsData.object ?? {});

                    widget.signTransaction
                        ?.call(controller, data, widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "signPersonalMessage":
                {
                  try {
                    final data = JsDataModel.fromJson(jsData.object ?? {});

                    widget.signPersonalMessage
                        ?.call(controller, data.data ?? "", widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "signMessage":
                {
                  try {
                    final data = JsDataModel.fromJson(jsData.object ?? {});

                    widget.signMessage
                        ?.call(controller, data.data ?? "", widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "signTypedMessage":
                {
                  final data = JsEthSignTypedData.fromJson(jsData.object ?? {});

                  try {
                    widget.signTypedMessage
                        ?.call(controller, data, widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "ecRecover":
                {
                  final data = JsEcRecoverObject.fromJson(jsData.object ?? {});

                  try {
                    widget.ecRecover
                        ?.call(controller, data, widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "requestAccounts":
                {
                  try {
                    debugPrint(widget.requestAccounts.toString());
                    widget.requestAccounts
                        ?.call(controller, "", widget.chainId)
                        .then((signedData) async {
                      final setAddress =
                          "window.ethereum.setAddress(\"${signedData.address}\");";
                      address = signedData.address!;
                      String callback =
                          "window.ethereum.sendResponse(${jsData.id}, [\"${signedData.address}\"])";
                       await _sendCustomResponse(controller, setAddress);
                       await _sendCustomResponse(controller, callback);

                      if (widget.chainId != signedData.chainId) {
                        final initString = _addChain(
                            signedData.chainId!,
                            signedData.rpcUrl!,
                            signedData.address!,
                            widget.isDebug);
                        widget.chainId = signedData.chainId!;
                        widget.rpc = signedData.rpcUrl!;
                        await _sendCustomResponse(controller, initString);
                      }
                    }).onError((e, stackTrace) {
                      debugPrint(e.toString());
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    debugPrint(e.toString());

                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "watchAsset":
                {
                  try {
                    final data = JsWatchAsset.fromJson(jsData.object ?? {});

                    widget.watchAsset
                        ?.call(controller, data, widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "addEthereumChain":
                {
                  try {
                    final data =
                        JsAddEthereumChain.fromJson(jsData.object ?? {});
                    widget.addEthereumChain
                        ?.call(controller, data, widget.chainId)
                        .then((signedData) {
                      final initString = _addChain(int.parse(data.chainId!),
                          signedData, address, widget.isDebug);
                      widget.chainId = int.parse(data.chainId!);
                      widget.rpc = signedData;
                      _sendCustomResponse(controller, initString);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              case "switchEthereumChain":
                {
                  try {
                    final data =
                        JsAddEthereumChain.fromJson(jsData.object ?? {});

                    widget.addEthereumChain
                        ?.call(controller, data, widget.chainId)
                        .then((signedData) {
                      _sendResult(
                          controller, "ethereum", signedData, jsData.id ?? 0);
                      widget.chainId = int.parse(data.chainId!);
                      widget.rpc = signedData;
                      final initString = _addChain(int.parse(data.chainId!),
                          signedData, address, widget.isDebug);
                      _sendCustomResponse(controller, initString);
                    }).onError((e, stackTrace) {
                      _sendError(
                          controller, "ethereum", e.toString(), jsData.id ?? 0);
                    });
                  } catch (e) {
                    _sendError(
                        controller, "ethereum", e.toString(), jsData.id ?? 0);
                  }
                  break;
                }
              default:
                {
                  _sendError(controller, jsData.network.toString(),
                      "Operation not supported", jsData.id ?? 0);
                  break;
                }
            }
          });
    }
    widget.initialized = true;
    return;
  }

  String _loadInitJs(int chainId, String rpcUrl) {
    String source = '''
        (function() {
            var config = {                
                ethereum: {
                    chainId: $chainId,
                    rpcUrl: "$rpcUrl"
                },
                solana: {
                    cluster: "mainnet-beta",
                },
                isDebug: true
            };
            trustwallet.ethereum = new trustwallet.Provider(config);
            trustwallet.solana = new trustwallet.SolanaProvider(config);
            trustwallet.postMessage = (json) => {
                window._tw_.postMessage(JSON.stringify(json));
            }
            window.ethereum = trustwallet.ethereum;
        })();
        ''';
    return source;
  }

  String _loadReInt(int chainId, String rpcUrl, String address) {
    String source = '''
        (function() {
          if(window.ethereum == null){
            var config = {                
                ethereum: {
                    chainId: $chainId,
                    rpcUrl: "$rpcUrl",
                    address: "$address"
                },
                solana: {
                    cluster: "mainnet-beta",
                },
                isDebug: true
            };
            trustwallet.ethereum = new trustwallet.Provider(config);
            trustwallet.solana = new trustwallet.SolanaProvider(config);
            trustwallet.postMessage = (json) => {
                window._tw_.postMessage(JSON.stringify(json));
            }
            window.ethereum = trustwallet.ethereum;
          }
        })();
        ''';
    return source;
  }

  String _addChain(int chainId, String rpcUrl, String address, bool isDebug) {
    String source = '''
        window.ethereum.setNetwork({
          ethereum:{
            chainId: $chainId,
            rpcUrl: "$rpcUrl",
            isDebug: $isDebug
            }
          }
        )
        ''';
    return source;
  }

  Future<void> _sendError(InAppWebViewController controller, String network,
      String message, int methodId) {
    String script = "window.$network.sendError($methodId, \"$message\")";
    return controller.evaluateJavascript(source: script);
  }

  Future<void> _sendResult(InAppWebViewController controller, String network,
      String message, int methodId) {
    String script = "window.$network.sendResponse($methodId, \"$message\")";
    debugPrint(script);
    return controller
        .evaluateJavascript(source: script)
        .then((value) => debugPrint(value))
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

  Future<void> _sendCustomResponse(
      InAppWebViewController controller, String response) {
    return controller
        .evaluateJavascript(source: response)
        .then((value) => debugPrint(value))
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

  Future<void> _sendResults(InAppWebViewController controller, String network,
      List<String> messages, int methodId) {
    String message = messages.join(",");
    String script = "window.$network.sendResponse($methodId, \"$message\")";
    return controller.evaluateJavascript(source: script);
  }
}
