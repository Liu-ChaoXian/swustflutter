import 'package:swustflutter/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swustflutter/pages/forget_password.dart';
import 'package:swustflutter/pages/register_account.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../config/constant.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _biggerFont =
      const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600);
  final _normalFont = const TextStyle(fontSize: 18.0);
  final _borderRadius = BorderRadius.circular(6);

  String _accountText = '';
  String _pwdText = '';
  bool _isEnableLogin = false;
  bool _obscureText = true;
  var _accountController = TextEditingController();
  var _pwdController = TextEditingController();

  void _checkUserInput() {
    /**
     * 是否允许登录按钮重绘条件：
     * 1、账户和密码均输入不为空
     * 2、当前记录的是否允许登录状态需要发生改变（注意这里不优化，可能导致大量无效重绘，
     *    如：已经允许登录，但是用户继续输入，此时没有必要频繁调用setState）
     * 3、请思考如何解决当允许登录状态改变时，不重绘整个LoginPage，而是局部发生重绘优化性能，
     *    在后期复杂场景下有助于性能提升。
     */
    if (_accountText.isNotEmpty && _pwdText.isNotEmpty) {
      if (_isEnableLogin) return;
    } else {
      if (!_isEnableLogin) return;
    }

    setState(() {
      _isEnableLogin = !_isEnableLogin;
    });
  }

  _getLoginButtonPressed() {
    if (!_isEnableLogin) return null;

    return () async {
      final SharedPreferences prefs = await _prefs;
      prefs.setString(Constant.userAccount, _accountText);
      prefs.setString(Constant.userPassword, _pwdText);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    };
  }

  @override
  void initState() {
    _prefs.then((prefs) {
      _accountText = prefs.getString(Constant.userAccount) ?? '';
      _accountController.text = _accountText;
      _pwdText = prefs.getString(Constant.userPassword) ?? '';
      _pwdController.text = _pwdText;
      _checkUserInput();
    });
  }

  List<String> picture = ['assets/image1.jpg','assets/image2.jpg','assets/image3.gif'];
  Widget _buildTopWidget() {
    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Image.asset(picture[index],fit: BoxFit.fill,);
        },
        itemCount: picture.length,
        pagination: new SwiperPagination(),
        loop: true,
        autoplay: true,
      ),
    );
  }

  Widget _buildAccountEditTextField() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: TextField(
        controller: _accountController,
        onChanged: (text) {
          _accountText = text;
          _checkUserInput();
        },
        style: _normalFont,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: '请输入手机号/用户名',
          filled: true,
          fillColor: Color.fromARGB(255, 240, 240, 240),
          contentPadding: EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: _borderRadius),
        ),
      ),
    );
  }

  Widget _buildPwdEditTextField() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextField(
        controller: _pwdController,
        onChanged: (text) {
          _pwdText = text;
          _checkUserInput();
        },
        style: _normalFont,
        obscureText: _obscureText, ///是否隐藏正在编辑的文本
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: '请输入登录密码',
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            contentPadding: EdgeInsets.only(left: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none, borderRadius: _borderRadius),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureText = !_obscureText),
              icon: Image.asset(
                _obscureText ? 'assets/closeEye.png' : 'assets/openEye.png',
                width: 20,
                height: 20,
              ),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent, // 去掉点击阴影效果
            )),
      ),
    );
  }

  Widget _buildElseText() { ///忘记密码和注册账户
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text('立即注册'),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    RegisterAccount(),
                ));
              },
            ),
            FlatButton(
              child: Text('忘记密码?'),
              splashColor: Colors.transparent, // 去掉点击阴影效果
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return new ForgetPassWord();
                }));
              },
            )
          ],
        ),
      );
  }

  Widget _buildLoginButton() {  ///登录按钮
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: RaisedButton(
        child: Text("登 录", style: _normalFont),
        color: Colors.blue,
        disabledColor: Colors.black12,
        textColor: Colors.white,
        disabledTextColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadius,
        ),
        onPressed: _getLoginButtonPressed(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登 录',),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopWidget(),///头部图片
            Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: <Widget>[
                  _buildAccountEditTextField(),
                  _buildPwdEditTextField(),
                  _buildElseText(),
                  _buildLoginButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
