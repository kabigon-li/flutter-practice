// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:onetime/di/state_notifier/theme_controller.dart';
// import 'package:onetime/models/theme/theme_mode_extension.dart';
// import 'package:onetime/constants/colors.dart';
// import 'package:onetime/constants/texts.dart';
// import 'package:onetime/screens/settings/widgets/setting_row.dart';
 
// class SettingsScreen extends HookWidget {
//  @override
// class SettingsScreen extends StatelessWidget {
//    Widget build(BuildContext context) {
//    final themeSelector = useProvider(themeSelectorProvider);
//    final currentThemeMode = useProvider(themeSelectorProvider.state);

//      return Scaffold(
//      backgroundColor: white,
//        appBar: AppBar(
//         title: const Text('設定'),
//       ),
//      body: SafeArea(
//        child: ListView.builder(
//          itemCount: ThemeMode.values.length,
//          itemBuilder: (_, index) {
//            final themeMode = ThemeMode.values[index];
//            return RadioListTile<ThemeMode>(
//               value: themeMode,
//               groupValue: currentThemeMode,
//               onChanged: (newTheme) {
//                 themeSelector.change(newTheme);
//               },
//              title: Text(themeMode.title),
//               subtitle: Text(themeMode.subtitle),
//               controlAffinity: ListTileControlAffinity.platform,
//             );
//           },
//         title: const Text(settings),
//       ),
//      body: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//            const SizedBox(height: 10),
//            buildProfileSection(context),
//           const SizedBox(height: 10),
//             buildDescriptionSection(context),
//             const SizedBox(height: 20),
//           ],
//          ),
//        ),
//      );
//    }
//  List<Widget> buildProfileSection(BuildContext context) {    return [
//       SettingTitle(
//         title: themeSettings,
//       ),
//       SettingRow(
//         title: darkMode,
//         isEnable: false,
//         onChange: (bool value) {},
//      ),
//     ];
//   }

// +  List<Widget> buildMessageSection(BuildContext context) {
// +    return [
// +      SettingTitle(
// +        title: accountSettings,
// +      ),
// +      SettingRow(
// +        title: darkMode,
// +        isEnable: false,
// +        onChange: (bool value) {},
// +      ),
// +    ];
// +  }
// +
// +  List<Widget> buildDescriptionSection(BuildContext context) {
// +    final privacyPolicyUrl = 'https://github.com/kayanoki-akinori/onetime';
// +    return [
// +      SettingTitle(
// +        title: appInfo,
// +      ),
// +      SettingRow(
// +        title: privacyPolicyTitle,
// +        onTap: () {},
// +      ),
// +      SettingRow(
// +        title: appInfo,
// +        onTap: () {},
// +      ),
// +      SettingRow(
// +        title: licenseInfo,
// +        onTap: () {},
// +      ),
// +      SettingRow(
// +        title: inquiry,
// +        onTap: () {},
// +      ),
// +      SettingRow(
// +        title: reviewApp,
// +        onTap: () {},
// +      ),
// +    ];
// +  }
//  }
