import 'dart:async';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

// see <https://qiita.com/agajo/items/3566ae44de12da603001>
class _SingleBanner {
  factory _SingleBanner() {
    return _instance ??= _SingleBanner._internal();
  }

  _SingleBanner._internal();
  static _SingleBanner _instance;

  BannerAd _bannerAd;
  int _ownerHashCode;

  void show({
    @required int callerHashCode,
    @required String adUnitId,
    @required AdSize size,
    @required double anchorOffset,
    @required bool isMounted,
  }) {
    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: size,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.loaded) {
          if (isMounted) {
            _bannerAd.show(anchorOffset: anchorOffset);
          } else {
            _bannerAd = null;
          }
        }
      },
    );
    _ownerHashCode = callerHashCode;
    _bannerAd.load();
  }

  void dispose({@required int callerHashCode}) {
    if (callerHashCode == _ownerHashCode) {
      _bannerAd?.dispose();
      _bannerAd = null;
    }
  }
}

// without Navigator
class AdmobBannerWidget extends StatefulWidget {
  const AdmobBannerWidget({_AdmobBannerWidgetState admobBannerWidgetState})
      : _admobBannerWidgetState = admobBannerWidgetState;
  final _AdmobBannerWidgetState _admobBannerWidgetState;

  @override
  _AdmobBannerWidgetState createState() =>
      _admobBannerWidgetState ?? _AdmobBannerWidgetState();
}

class _AdmobBannerWidgetState extends State<AdmobBannerWidget> {
  Timer _timer;
  double _bannerHeight;
  AdSize _adSize;
  bool isTop = true;

  void _loadAndShowBanner() {
    assert(_bannerHeight != null);
    assert(_adSize != null);
    _timer?.cancel();
    // wait widget rendering
    _timer =
        Timer.periodic(const Duration(seconds: 1), (Timer _thisTimer) async {
      final RenderBox _renderBox = context.findRenderObject();
      final _isRendered = _renderBox.hasSize;
      if (_isRendered) {
        _SingleBanner().show(
          isMounted: mounted,
          anchorOffset: _anchorOffset(),
          adUnitId: BannerAd.testAdUnitId,
          callerHashCode: hashCode,
          size: _adSize,
        );
        _thisTimer.cancel();
      }
    });
  }

  // ノッチとかを除いた範囲(SafeArea)の縦幅の1/8以内で最大の広告を表示します。
  // 広告の縦幅を明確にしたいのでSmartBannerは使いません。
  void _determineBannerSize() {
    final _viewPaddingTop = WidgetsBinding.instance.window.viewPadding.top /
        MediaQuery.of(context).devicePixelRatio;
    final _viewPaddingBottom =
        WidgetsBinding.instance.window.viewPadding.bottom /
            MediaQuery.of(context).devicePixelRatio;
    final _screenWidth = MediaQuery.of(context).size.width;
    final _availableScreenHeight = MediaQuery.of(context).size.height -
        _viewPaddingTop -
        _viewPaddingBottom;
    if (_screenWidth >= 728 && _availableScreenHeight >= 720) {
      _adSize = AdSize.leaderboard;
      _bannerHeight = 90;
    } else if (_screenWidth >= 468 && _availableScreenHeight >= 480) {
      _adSize = AdSize.fullBanner;
      _bannerHeight = 60;
    } else if (_screenWidth >= 320 && _availableScreenHeight >= 800) {
      _adSize = AdSize.largeBanner;
      _bannerHeight = 100;
    } else {
      _adSize = AdSize.banner;
      _bannerHeight = 50;
    }
  }

  // ノッチとかを除いた範囲(SafeArea)の下端を基準に、
  // このWidgetが論理ピクセルいくつ分だけ上に表示されているか計算します
  double _anchorOffset() {
    final RenderBox _renderBox = context.findRenderObject();
    assert(_renderBox.hasSize);
    final _y = _renderBox.localToGlobal(Offset.zero).dy;
    final _h = _renderBox.size.height;
    // viewPaddingだけ何故かMediaQueryで取得すると0だったので、windowから直接取得
    // 物理ピクセルが返るのでdevicePicelRatioで割って論理ピクセルに直す
    final _vpb = WidgetsBinding.instance.window.viewPadding.bottom /
        MediaQuery.of(context).devicePixelRatio;
    final _screenHeight = MediaQuery.of(context).size.height;
    return _screenHeight - _y - _h - _vpb;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _bannerHeight,
      color: Colors.yellow,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // reload ads
    disposeBanner();
    if (isTop) {
      _determineBannerSize();
      _loadAndShowBanner();
    }
  }

  @override
  void dispose() {
    disposeBanner();
    super.dispose();
  }

  void disposeBanner() {
    _SingleBanner().dispose(callerHashCode: hashCode);
    _timer?.cancel();
  }
}

// with Navigator
class AdmobBannerWidgetWithRoute extends StatefulWidget {
  const AdmobBannerWidgetWithRoute();
  @override
  _AdmobBannerWidgetWithRouteState createState() =>
      _AdmobBannerWidgetWithRouteState();
}

class _AdmobBannerWidgetWithRouteState extends State<AdmobBannerWidgetWithRoute>
    with RouteAware {
  final _AdmobBannerWidgetState _admobBannerWidgetState =
      _AdmobBannerWidgetState();
  AdmobBannerWidget _admobBannerWidget;
  RouteObserver<dynamic> _routeObserver;

  @override
  void initState() {
    super.initState();
    _admobBannerWidget =
        AdmobBannerWidget(admobBannerWidgetState: _admobBannerWidgetState);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO(some): is not first observer
    _routeObserver = Navigator.of(context).widget.observers.first;
    _routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    assert(_routeObserver != null);
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    _admobBannerWidgetState
      ..disposeBanner()
      ..isTop = false;
  }

  @override
  void didPopNext() {
    _admobBannerWidgetState
      ..isTop = true
      .._determineBannerSize()
      .._loadAndShowBanner();
  }

  @override
  void didPop() {
    _admobBannerWidgetState.disposeBanner();
  }

  @override
  Widget build(BuildContext context) {
    return _admobBannerWidget;
  }
}
