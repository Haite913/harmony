import{ http } from '@kit.NetworkKit'
import router from '@ohos.router'
import { rcp } from '@kit.RemoteCommunicationKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct LoginPage {

  text: string = ''
  account: string = ''
  password: string = ''

  handleLogin(){
    const req = http.createHttp()
    req.request('http://192.168.236.114:8866/ptjs/user/login',{method: http.RequestMethod.POST}).then((res: http.HttpResponse) => {
      // console.log(JSON.stringify(res))
      console.log("Connect Successful")
      // AlertDialog.show({message: JSON.stringify(res) })

    })

    // console.log("hello world")
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

            Text('欢迎使用xx系统！')
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

          // 用户名和密码输入框
          Column() {
            // 用户名输入框
            Column() {
              TextInput({ placeholder: '请输入用户名', text: this.account })
                .onChange((value: string) => {
                  this.account = value;
                })
                .fontSize(18)
                .fontColor(Color.Black)
                .width('100%')
                .height(50)
                .padding({ left: 10, right: 10 });
              Divider().height(1).color('#194487fe'); // 下划线
            }

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
            }.margin({ top: 32 });
          }
          .width('100%')
          .padding({ left: 32, right: 32 })
          .backgroundColor(Color.White);


          // 登录按钮
          Button('登 录')
            .width('60%')
            .height(50)
            .backgroundColor(Color.Red)
            .fontSize(18)
            .fontColor(Color.White)
            .onClick(() => {
              // 处理登录逻辑，并且在用户选择记住密码时保存密码
              this.handleLogin();

              // router.pushUrl({url: "pages/Second"})
            })
            .margin({ top: 56 });

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