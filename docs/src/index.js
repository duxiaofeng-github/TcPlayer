import { TcPlayer } from "tcplayer";

var player = new TcPlayer("id_test_video", {
  m3u8: "https://content.jwplatform.com/manifests/yp34SRmf.m3u8", //请替换成实际可用的播放地址
  autoplay: true, //iOS 下 safari 浏览器，以及大部分移动端浏览器是不开放视频自动播放这个能力的
  poster: "",
  width: "480", //视频的显示宽度，请尽量使用视频分辨率宽度
  height: "320" //视频的显示高度，请尽量使用视频分辨率高度
});
