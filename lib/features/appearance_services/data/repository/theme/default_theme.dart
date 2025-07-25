part of '../../../appearance_services.dart';

class DefaultTheme extends ThemeTemplate {
  const DefaultTheme();

  @override
  ThemeData get lightTheme => getThemeByScheme(_lightColorScheme);

  @override
  ThemeData get darkTheme => getThemeByScheme(_darkColorScheme);

  ColorScheme get _lightColorScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff55615d),
        surfaceTint: Color(0xff55615d),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffd7e4df),
        onPrimaryContainer: Color(0xff3e4a46),
        secondary: Color(0xff5b5f5d),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffe1e5e2),
        onSecondaryContainer: Color(0xff454a48),
        tertiary: Color(0xff5d5e68),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffe1e0ed),
        onTertiaryContainer: Color(0xff464651),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        surface: Color(0xfffbf9f8),
        onSurface: Color(0xff1b1c1b),
        onSurfaceVariant: Color(0xff434846),
        outline: Color(0xff737876),
        outlineVariant: Color(0xffc3c8c5),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff303030),
        inversePrimary: Color(0xffbcc9c5),
        primaryFixed: Color(0xffd8e5e0),
        onPrimaryFixed: Color(0xff121e1b),
        primaryFixedDim: Color(0xffbcc9c5),
        onPrimaryFixedVariant: Color(0xff3d4946),
        secondaryFixed: Color(0xffe0e3e1),
        onSecondaryFixed: Color(0xff181c1b),
        secondaryFixedDim: Color(0xffc3c7c5),
        onSecondaryFixedVariant: Color(0xff434846),
        tertiaryFixed: Color(0xffe2e1ee),
        onTertiaryFixed: Color(0xff1a1b24),
        tertiaryFixedDim: Color(0xffc6c5d2),
        onTertiaryFixedVariant: Color(0xff454650),
        surfaceDim: Color(0xffdcd9d8),
        surfaceBright: Color(0xfffbf9f8),
        surfaceContainerLowest: Color(0xffffffff),
        surfaceContainerLow: Color(0xfff6f3f2),
        surfaceContainer: Color(0xfff0edec),
        surfaceContainerHigh: Color(0xffeae8e6),
        surfaceContainerHighest: Color(0xffe4e2e1),
      );

  ColorScheme get _darkColorScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffffffff),
        surfaceTint: Color(0xffbcc9c5),
        onPrimary: Color(0xff273330),
        primaryContainer: Color(0xffcad7d2),
        onPrimaryContainer: Color(0xff36423e),
        secondary: Color(0xffc3c7c5),
        onSecondary: Color(0xff2d3130),
        secondaryContainer: Color(0xff3a3e3c),
        onSecondaryContainer: Color(0xffced2cf),
        tertiary: Color(0xffffffff),
        onTertiary: Color(0xff2f3039),
        tertiaryContainer: Color(0xffd4d3e0),
        onTertiaryContainer: Color(0xff3e3f49),
        error: Color(0xffffb4ab),
        onError: Color(0xff690005),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xffffdad6),
        surface: Color(0xff131313),
        onSurface: Color(0xffe4e2e1),
        onSurfaceVariant: Color(0xffc3c8c5),
        outline: Color(0xff8d928f),
        outlineVariant: Color(0xff434846),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffe4e2e1),
        inversePrimary: Color(0xff55615d),
        primaryFixed: Color(0xffd8e5e0),
        onPrimaryFixed: Color(0xff121e1b),
        primaryFixedDim: Color(0xffbcc9c5),
        onPrimaryFixedVariant: Color(0xff3d4946),
        secondaryFixed: Color(0xffe0e3e1),
        onSecondaryFixed: Color(0xff181c1b),
        secondaryFixedDim: Color(0xffc3c7c5),
        onSecondaryFixedVariant: Color(0xff434846),
        tertiaryFixed: Color(0xffe2e1ee),
        onTertiaryFixed: Color(0xff1a1b24),
        tertiaryFixedDim: Color(0xffc6c5d2),
        onTertiaryFixedVariant: Color(0xff454650),
        surfaceDim: Color(0xff131313),
        surfaceBright: Color(0xff393939),
        surfaceContainerLowest: Color(0xff0e0e0e),
        surfaceContainerLow: Color(0xff1b1c1b),
        surfaceContainer: Color(0xff1f201f),
        surfaceContainerHigh: Color(0xff2a2a29),
        surfaceContainerHighest: Color(0xff353534),
      );
}
