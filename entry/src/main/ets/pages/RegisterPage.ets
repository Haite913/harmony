// Index.ets
@Entry
@Component
struct Index {
  text: string = ''
  name: string = ''
  username: string = ''
  password: string = ''
  identity: number = 0

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
              // 处理登录逻辑，并且在用户选择记住密码时保存密码
              //this.handleLogin();
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