// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsLauncherIconGen {
  const $AssetsLauncherIconGen();

  /// File path: assets/launcher_icon/config.yaml
  String get config => 'assets/launcher_icon/config.yaml';

  /// File path: assets/launcher_icon/ic_launcher.png
  AssetGenImage get icLauncher =>
      const AssetGenImage('assets/launcher_icon/ic_launcher.png');

  /// File path: assets/launcher_icon/ic_launcher_background.png
  AssetGenImage get icLauncherBackground =>
      const AssetGenImage('assets/launcher_icon/ic_launcher_background.png');

  /// File path: assets/launcher_icon/ic_launcher_foreground.png
  AssetGenImage get icLauncherForeground =>
      const AssetGenImage('assets/launcher_icon/ic_launcher_foreground.png');

  /// File path: assets/launcher_icon/ic_launcher_monochrome.png
  AssetGenImage get icLauncherMonochrome =>
      const AssetGenImage('assets/launcher_icon/ic_launcher_monochrome.png');

  /// File path: assets/launcher_icon/icon.png
  AssetGenImage get icon =>
      const AssetGenImage('assets/launcher_icon/icon.png');

  /// List of all assets
  List<dynamic> get values => [
    config,
    icLauncher,
    icLauncherBackground,
    icLauncherForeground,
    icLauncherMonochrome,
    icon,
  ];
}

class $AssetsNativeSplashGen {
  const $AssetsNativeSplashGen();

  /// File path: assets/native_splash/config.yaml
  String get config => 'assets/native_splash/config.yaml';

  /// File path: assets/native_splash/splash.png
  AssetGenImage get splash =>
      const AssetGenImage('assets/native_splash/splash.png');

  /// List of all assets
  List<dynamic> get values => [config, splash];
}

class Assets {
  const Assets._();

  static const $AssetsLauncherIconGen launcherIcon = $AssetsLauncherIconGen();
  static const String logo = 'assets/logo.svg';
  static const $AssetsNativeSplashGen nativeSplash = $AssetsNativeSplashGen();

  /// List of all assets
  static List<String> get values => [logo];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
