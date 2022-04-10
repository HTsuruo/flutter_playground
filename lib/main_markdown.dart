import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_playground/logger.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ),
      home: const HomePage(),
    );
  }
}

const markdownSyntax = '''# H1
## H2
### H3
#### H4
##### H5
- list1
- list2
- list3
---

**Bold**

*Italic*

***BoldItalic***

Insert emoji here😀

![This is a alt text.](https://pbs.twimg.com/profile_banners/748518109699543040/1615150728/1500x500 "This is a sample image.")

[リンクサンプル](https://markdownlivepreview.com/)

[不正なリンクフォーマット](htt://markdownlivepreview.com/)

> 引用文もかける

```
コードブロックはcardのcolorを使うのでlightThemeのデフォルトだと白になってしまう。
color: theme.cardTheme.color ?? theme.cardColor,
`MarkdownStyleSheetBaseTheme.cupertino`を使うとsystemColorになるがフォントサイズが大きくなる
```

''';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            // `Markdown`Widgetは内部でListViewを持っているのが特徴
            child: Markdown(
              data: markdownSyntax,
              // selectable: true,
              onTapLink: (_, href, __) async {
                // `href`はnullable
                // リンクフォーマットにも関わらずhttp or httpsではじまらない場合にnullで返ってくる
                assert(
                  href != null,
                  'Invalid link, required `http://~` or `https://~`',
                );
                if (await canLaunch(href!)) {
                  await launch(href, forceSafariVC: true);
                } else {
                  logger.warning('Invalid `href` format');
                }
              },
            ),
          ),
          // 単純にパーサーとして使いたい場合は`MarkdownBody`とすると良い
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: MarkdownBody(
                  data: markdownSyntax,
                  // selectable: true,
                  onTapLink: (text, href, title) =>
                      launch(href!, forceSafariVC: true),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
