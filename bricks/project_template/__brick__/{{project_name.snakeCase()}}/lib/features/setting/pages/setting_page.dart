import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/repositories/package_info/package_info_repository.dart';
import '../../../core/utils/constants.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  static String get pageName => 'setting';

  static Future<void> show(BuildContext context) async {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => const SettingPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appVersion = ref.watch(packageInfoRepositoryProvider).appVersion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Text(
                  'アプリ',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('ストアを開く'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      onTap: () {
                        final url = context.isIOS ? appStoreUrl : googlePlayUrl;
                        launchUrlString(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    const Divider(height: 1),
                    Builder(
                      builder: (context) {
                        return ListTile(
                          title: const Text('友達に紹介する'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                          ),
                          onTap: () {
                            final box =
                                context.findRenderObject() as RenderBox?;
                            if (box == null) {
                              return;
                            }
                            final url =
                                context.isIOS ? appStoreUrl : googlePlayUrl;
                            Share.share(
                              url,
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size,
                            );
                          },
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('アプリを応援する'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      onTap: () {
                        LaunchReview.launch(
                          androidAppId: androidId,
                          iOSAppId: appleId,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 8),
                child: Text(
                  'その他',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('利用規約'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      onTap: () {
                        launchUrlString(termsOfRulesUrl);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('プライバシーポリシー'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      onTap: () {
                        launchUrlString(privacyPolicyUrl);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('ライセンス'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                      onTap: () {
                        showLicensePage(context: context);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('アプリバージョン'),
                      trailing: Text(
                        appVersion,
                        style: context.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
