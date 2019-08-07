## 腾讯云 web 播放器 SDK

本库为腾讯云直播的 web 播放器 sdk 镜像。

### 源文件\n\n* [https://imgcache.qq.com/open/qcloud/video/vcplayer/TcPlayer-2.3.1.js](https://imgcache.qq.com/open/qcloud/video/vcplayer/TcPlayer-2.3.1.js)

### 腾讯云直播 web 播放器文档

[https://cloud.tencent.com/document/product/881/20207](https://cloud.tencent.com/document/product/881/20207)

## 广告

腾讯这个 sdk 闭源，代码写得忒烂，直播 rtmp 时使用的 swf 事件不全，bug 众多，又无处反馈。

so，我自己写了个播放器，用在公司项目中，各位有兴趣可以来使用、拍砖、贡献代码。

传送门：[https://github.com/duxiaofeng-github/zaojiu-player](https://github.com/duxiaofeng-github/zaojiu-player)

## 安装

```bash
npm install tcplayer --save
```

or

```bash
yarn add tcplayer
```

如果需要锁定某个版本，如下：

```bash
npm install tcplayer@0.0.1 --save
```

or

```bash
yarn add tcplayer@0.0.1
```

## 使用

参见 [./docs](./docs)

## 自动更新

本库每天会使用 travis 做定时自动更新，检查源地址文件是否变更，变更则自动提交 commit，tag 自增，并自动发布到 [npm](https://www.npmjs.com/package/tcplayer) 。

## LICENSE

MIT
