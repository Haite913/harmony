import{ http } from '@kit.NetworkKit'
import router from '@ohos.router'
import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import {  } from '@ohos.window';

// Index.ets
@Entry
@Component
struct Index {
  text: string = ''
  name: string = ''
  username: string = ''
  password: string = ''
  identity: number = 1

  handleregister() {
    interface UserDto {
      identity: number;
      username: string;
      password: string;
      name: string;
    }

    // 构建请求体
    const userDto: UserDto = {
      identity: 1,
      name: this.name,
      username: this.username,
      password: this.password,
    };
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/user/register`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
      {
        method: http.RequestMethod.POST, // 设置请求方法为post
        header: {
          'Content-Type': 'application/json' // 设置请求头Content-Type为application/json
        },
        // 将请求体转换为字符串
        extraData: JSON.stringify(userDto),
      },
      (err: BusinessError, data: http.HttpResponse) => {
        interface ResultObject {
          code: number;
          msg: string;
          data: object; // 或者更具体的类型，取决于你的数据结构
        }

        // let obj :ResultObject = JSON.parse(data.result.toString())
        if (data.responseCode == 200) {
          // 请求成功，处理响应数据
          console.info('Result:' + JSON.stringify(data.result));
          console.info('code:' + JSON.stringify(data.responseCode));
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
          // 显示注册成功弹窗
          this.getUIContext().showAlertDialog(
            {
              title: '注册',
              message: '注册成功',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              offset: { dx: 0, dy: -20 },
              gridCount: 3,
              transition: TransitionEffect.asymmetric(TransitionEffect.OPACITY
                .animation({ duration: 3000, curve: Curve.Sharp })
                .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 }).animation({ duration: 3000, curve: Curve.Sharp })),
                TransitionEffect.OPACITY.animation({ duration: 100, curve: Curve.Smooth })
                  .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
                    .animation({ duration: 100, curve: Curve.Smooth }))),
              buttons: [{
                value: 'cancel',
                action: () => {
                  console.info('Callback when the first button is clicked')
                }
              },
                {
                  enabled: true,
                  defaultFocus: true,
                  style: DialogButtonStyle.HIGHLIGHT,
                  value: 'ok',
                  action: () => {
                    console.info('Callback when the second button is clicked')
                  }
                }],
            }
          )
          router.pushUrl({url: "pages/LoginPage"})
          httpRequest.destroy();
        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
          // 显示注册失败弹窗
          this.getUIContext().showAlertDialog(
            {
              title: '注册',
              message: '注册失败',
              autoCancel: true,
              alignment: DialogAlignment.Center,
              offset: { dx: 0, dy: -20 },
              gridCount: 3,
              transition: TransitionEffect.asymmetric(TransitionEffect.OPACITY
                .animation({ duration: 3000, curve: Curve.Sharp })
                .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 }).animation({ duration: 3000, curve: Curve.Sharp })),
                TransitionEffect.OPACITY.animation({ duration: 100, curve: Curve.Smooth })
                  .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
                    .animation({ duration: 100, curve: Curve.Smooth }))),
              buttons: [{
                value: 'cancel',
                action: () => {
                  console.info('Callback when the first button is clicked')
                }
              },
                {
                  enabled: true,
                  defaultFocus: true,
                  style: DialogButtonStyle.HIGHLIGHT,
                  value: 'ok',
                  action: () => {
                    console.info('Callback when the second button is clicked')
                  }
                }],
            }
          )
        }
      }
    );
  }
  build() {
    Stack() {
      Column() {
        // 顶部的欢迎文字
        Text(this.text)
        Column() {
          RelativeContainer() {
            Text('您好！')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Red)
              .alignRules({
                top: { anchor: '__container__', align: VerticalAlign.Top },
                center: { anchor: '__container__', align: VerticalAlign.Center }
              })
              .width('100%');

            Text('欢迎注册集大勤工系统账号！')
              .fontSize(22)
              .fontColor(Color.Black)
              .alignRules({
                bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
                center: { anchor: '__container__', align: VerticalAlign.Center }
              })
              .width('100%')
              .margin({ top: 80 });
          }
          .height('30%')
          .width('100%')
          .padding({ left: 32, right: 32 })
          .backgroundColor(Color.White);

          // 姓名.用户名,密码输入框
          Column() {
            // 姓名输入框
            Column() {
              TextInput({ placeholder: '请输入姓名', text: this.name })
                .onChange((value: string) => {
                  this.name = value;
                })
                .fontSize(18)
                .fontColor(Color.Black)
                .width('100%')
                .height(50)
                .padding({ left: 10, right: 10 });
              Divider().height(1).color('#194487fe'); // 下划线
            }

            // 用户名输入框
            Column() {
              TextInput({ placeholder: '请输入用户名', text: this.username })
                .onChange((value: string) => {
                  this.username = value;
                })
                .fontSize(18)
                .fontColor(Color.Black)
                .width('100%')
                .height(50)
                .padding({ left: 10, right: 10 });
              Divider().height(1).color('#194487fe'); // 下划线
            }.margin({ top: 20 });

            // 密码输入框
            Column() {
              TextInput({ placeholder: '请输入密码', text: this.password })
                .onChange((value: string) => {
                  this.password = value;
                })
                .fontSize(18)
                .fontColor(Color.Black)
                .width('100%')
                .height(50)
                .padding({ left: 10, right: 10 })
                .type(InputType.Password);
              Divider().height(1).color('#194487fe'); // 下划线
            }.margin({ top: 20 });
          }
          .width('100%')
          .padding({ left: 32, right: 32 })
          .backgroundColor(Color.White);


          // 注册按钮
          Button('注 册')
            .width('60%')
            .height(50)
            .backgroundColor(Color.Red)
            .fontSize(18)
            .fontColor(Color.White)
            .onClick(() => {
              // 处理注册逻辑，并且在用户选择记住密码时保存密码
              console.info(this.name)
              console.info(this.username)
              console.info(this.password)
              this.handleregister();
            })
            .margin({ top: 56 });


          // 登录按钮
          Button('登 录')
            .width('60%')
            .height(50)
            .backgroundColor(Color.Red)
            .fontSize(18)
            .fontColor(Color.White)
            .onClick(() => {
              // 跳转登陆页面
              router.pushUrl({url: "pages/LoginPage"})
            })
            .margin({ top: 32 });


          // 底部图片
          //   Image($r('app.media.login_bottom'))
          //     .width('100%');
          // }
          // .height('100%')
          // .width('100%')
          // .backgroundColor(Color.White)
          // .justifyContent(FlexAlign.SpaceBetween);

        }
      }
    }
  }
}