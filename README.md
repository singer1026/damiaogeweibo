<pre>
/*
                                 _ooOoo_
                                o8888888o
                                88" . "88
                                (| -_- |)
                                O\  =  /O
                             ____/`---'\____
                           .'  \\|     |//  `.
                          /  \\|||  :  |||//  \
                         /  _||||| -:- |||||-  \
                         |   | \\\  -  /// |   |
                         | \_|  ''\---/''  |_/ |
                          \.-\__   `-`  ___/-./
                       ___`. .'  /--.--\  `. . ___
                    ."" '<  `.___\_<|>_/___.'  >' "".
                   | | :  `- \`.;`\ _ /`;.`/ - ` : | |
                   \  \ `-.   \_ __\ /__ _/   .-` /  /
              ======`-.____`-.___\_____/___.-`____.-'======
                                 `=---='
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                          佛祖保佑       永无BUG
 */
</pre>
大喵哥微博，仿新浪微博，使用新浪微博的SDK进行开发(跟着视频写的)。
使用了MBProgressHUD、AFNetworking、SDWebImage、MJRefresh
***

使用方法<br/>
1.在http://open.weibo.com 里面申请一个移动手机app应用

2.获取到你自己应用的App Key、App Secret、Bundle ID（Apple ID暂时可以随便填写）<br/>
注：App Key、App Secret是微博应用自动分配给你的；Bundle ID是自己填写的；下面两个地方的Bundle ID要保持一致
可以通过修改damiaogeweibo-Info.plist中Bundle identifier来达到和网站的那个Bundle ID一致；

3.修改damiaogeweibo-Prefix.pch文件中的kAppKey、kAppSecret、kRedirectURI为你自己的

4.在damiaogeweibo-Info.plist中增加url types，在url schems里填上wbXXXX(你自己的AppKey) <br/>
注：如果不修改此处，手机里如果安装了官方微博客户端的话则在登录后无法跳回到自己的应用中

5.如果需要用其他微博帐号登录测试，则需要在微博应用管理中心--->应用信息--->测试信息中添加测试帐号的微博昵称





![alt Home](https://raw.githubusercontent.com/singer1026/damiaogeweibo/master/Screens/a.png)

![alt Home](https://raw.githubusercontent.com/singer1026/damiaogeweibo/master/Screens/b.png)

![alt Home](https://raw.githubusercontent.com/singer1026/damiaogeweibo/master/Screens/c.png)

![alt Home](https://raw.githubusercontent.com/singer1026/damiaogeweibo/master/Screens/1.png)