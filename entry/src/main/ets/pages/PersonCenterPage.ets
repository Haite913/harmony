import { router } from '@kit.ArkUI'
import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
export const BASE_URL: string = 'https://lblbc.cn/';



interface ResultObject {
  code: number;
  msg: string;
  data: DataContainer; // 或者更具体的类型，取决于你的数据结构
}
interface DataContainer {
  code: number;
  msg: string;
  data: ApplyResult; // 同样使用可选属性操作符
}
interface ApplyResult{
  id:number
  name:string
  username:string
  password:string
  major:string
  classes:string
  phone:string
  poorSymbol:boolean
  identity:number
  delFlag:number
  schoolId:number
  faculty:string
  grade:string
  qq:string
  bankCardNumber:string
}

@Entry
@Component
struct PersonCenterPage {
  @StorageProp('username') username: string = ''
  @State index: number = 3


  @State applyPosition:ApplyResult = {
    id: 0,
    name: '',
    username: '',
    password: '',
    major: '',
    classes: '',
    phone: '',
    poorSymbol: false,
    identity: 0,
    delFlag: 0,
    schoolId: 0,
    faculty: '',
    grade: '',
    qq: '',
    bankCardNumber: ''
  }

  @State applyResult: ApplyResult[] = [];

  Getuserdata() {
    // 构建请求体
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/user/${this.username}`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
      {
        method: http.RequestMethod.GET, // 设置请求方法为GET
        header: {
          'Content-Type': 'application/json', // 设置请求头Content-Type为application/json
        },
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if (data.responseCode === 200) {
          console.info('Result:' + JSON.stringify(data.result));
          console.info('code:' + JSON.stringify(data.responseCode));
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies));
          const resultObject: DataContainer = JSON.parse(data.result.toString());


          this.applyPosition= {
              id: resultObject.data.id,
              name: resultObject.data.name,
              username: resultObject.data.username,
              password: resultObject.data.password,
              major: resultObject.data.major,
              classes: resultObject.data.classes,
              phone: resultObject.data.phone,
              poorSymbol: resultObject.data.poorSymbol,
              identity: resultObject.data.identity,
              delFlag: resultObject.data.delFlag,
              schoolId: resultObject.data.schoolId,
              faculty: resultObject.data.faculty,
              grade: resultObject.data.grade,
              qq: resultObject.data.qq,
              bankCardNumber: resultObject.data.bankCardNumber
            }
          console.info('poorSymbol:', this.applyPosition.poorSymbol);

        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
        }
      }
    );
  }
  submitUpdata(){
    let httpRequest = http.createHttp();
    const updatedData = this.applyPosition;
    interface data{
      id:number
      name:string
      username:string
      password:string
      major:string
      classes:string
      phone:string
      poorSymbol:number
      identity:number
      schoolId:number
      faculty:string
      grade:string
      qq:string
      bankCardNumber:string
    }
    const updata:data= {
      id: this.applyPosition.id,
      name: this.applyPosition.name,
      username: this.applyPosition.username,
      password: this.applyPosition.password,
      major: this.applyPosition.major,
      classes: this.applyPosition.classes,
      phone: this.applyPosition.phone,
      poorSymbol: this.applyPosition.poorSymbol?1:0,
      identity: this.applyPosition.identity,
      schoolId: this.applyPosition.schoolId,
      faculty: this.applyPosition.faculty,
      grade: this.applyPosition.grade,
      qq: this.applyPosition.qq,
      bankCardNumber: this.applyPosition.bankCardNumber
    }


    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/user`,
      {
        method: http.RequestMethod.PUT,
        header: {
          'Content-Type': 'application/json',
        },
        extraData:JSON.stringify(updata)
        /*{
          id: this.applyPosition.id,
          name: this.applyPosition.name,
          username: this.applyPosition.username,
          password: this.applyPosition.password,
          major: this.applyPosition.major,
          classes: this.applyPosition.classes,
          phone: this.applyPosition.phone,
          poorSymbol: this.applyPosition.poorSymbol,
          identity: this.applyPosition.identity,
          schoolId: this.applyPosition.schoolId,
          faculty: this.applyPosition.faculty,
          grade: this.applyPosition.grade,
          qq: this.applyPosition.qq,
          bankCardNumber: this.applyPosition.bankCardNumber
        },*/
      },
      (err: BusinessError, data: http.HttpResponse) => {
        console.log('发送的数据:', JSON.stringify(updata));
        if (data.responseCode === 200) {
          console.info('更新成功');
          // 在此做后续操作，比如返回上一页，显示提示等
        } else {
          console.error('更新失败：', err);
          console.error('响应数据:', JSON.stringify(data));
        }
      }
    );
  }





  @Builder NavigationMenus() { // CustomBuilder类型的菜单栏
    Row() {
      Image($r('app.media.startIcon'))
        .size({ width: 24, height: 24 })
      Image($r('app.media.startIcon'))
        .size({ width: 24, height: 24 })
        .margin({ left: 5 })
      Image($r('app.media.startIcon'))
        .size({ width: 24, height: 24 })
        .margin({ left: 5 })
      Image($r('app.media.startIcon'))
        .size({ width: 24, height: 24 })
        .margin({ left: 5 })
    }.justifyContent(FlexAlign.End)
  }

  @Builder NavigationToolbar() { // CustomBuilder类型的toolbar
    Row() {
      Column() {
        Image(this.index == 0 ? $r('app.media.layered_image') : $r('app.media.foreground'))
          .size({ width: 25, height: 25 })
        Text('首页')
          .fontSize(16)
          .fontColor(this.index == 0 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        router.pushUrl({url:'pages/HomePage'})
      })

      Column() {
        Image(this.index == 1 ? $r('app.media.layered_image') : $r('app.media.foreground'))
          .size({ width: 25, height: 25 })
        Text('岗位列表')
          .fontSize(16)
          .fontColor(this.index == 1 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        router.pushUrl({url:'pages/JobListPage'})
      })

      Column() {
        Image(this.index == 2 ? $r('app.media.layered_image') : $r('app.media.foreground'))
          .size({ width: 25, height: 25 })
        Text('申请列表')
          .fontSize(16)
          .fontColor(this.index == 2 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        router.pushUrl({url:'pages/ApplyListPage'})
      })

      Column() {
        Image(this.index == 3 ? $r('app.media.layered_image') : $r('app.media.foreground'))
          .size({ width: 25, height: 25 })
        Text('个人中心')
          .fontSize(16)
          .fontColor(this.index == 3 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        router.pushUrl({url:'pages/PersonCenterPage'})
      })
    }
    .width('100%')
    .height(50)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Navigation(){
        //代码编写位置
        Text('个人中心')
          .onAppear(()=>{
            this.Getuserdata()
          })
        Column(){
          Flex({direction:FlexDirection.Column}){
              Flex({direction:FlexDirection.Row}){
                Text('姓名')
                  .layoutWeight(1)
                  .padding(10)
                  .fontSize(17)
                TextInput({text:this.applyPosition.name})
                  .layoutWeight(4)
                  .onChange((newValue: string) => {
                    this.applyPosition.name = newValue;
                  })

              }
              .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('专业')
                .layoutWeight(1)
                .padding(10)
                .fontSize(17)
              TextInput({text:this.applyPosition.major})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.major = newValue;
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('班级')
                .layoutWeight(1)
                .padding(10)
                .fontSize(17)
              TextInput({text:this.applyPosition.classes})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.classes = newValue;
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('银行卡号')
                .layoutWeight(1)
                .padding(10)
                .fontSize(16)
              TextInput({text:this.applyPosition.bankCardNumber})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.bankCardNumber = newValue;
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('联系电话')
                .layoutWeight(1)
                .padding(10)
                .fontSize(16)
              TextInput({text:this.applyPosition.phone})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.phone = newValue;
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('学号')
                .layoutWeight(1)
                .padding(10)
                .fontSize(17)
              TextInput({text:this.applyPosition.schoolId.toString()})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.schoolId = Number(newValue);
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('院系')
                .layoutWeight(1)
                .padding(10)
                .fontSize(17)
              TextInput({text:this.applyPosition.faculty})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.faculty = newValue;
                })


            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('年级')
                .layoutWeight(1)
                .padding(10)
                .fontSize(17)
              TextInput({text:this.applyPosition.grade})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.grade = newValue;
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('QQ')
                .layoutWeight(1)
                .padding(10)
                .fontSize(17)
              TextInput({text:this.applyPosition.qq})
                .layoutWeight(4)
                .onChange((newValue: string) => {
                  this.applyPosition.qq = newValue;
                })

            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Text('贫困生')
                .padding(10)
                .fontSize(17)
              Toggle({type:ToggleType.Switch,isOn:!!this.applyPosition.poorSymbol})
                .margin({top:8})
                .onChange((newValue: boolean) => {
                  this.applyPosition.poorSymbol = newValue;
                })
            }
            .padding(5)

            Flex({direction:FlexDirection.Row}){
              Button('提交修改')
                .backgroundColor(Color.Pink)
                .align(Alignment.Center)

            }
            .margin({left:110})
            .padding(5)
            .onClick(()=>{
              this.submitUpdata();
            })
          }
        }
        .padding(25)

      }
      .title("ArkUI")
      .mode(NavigationMode.Stack)
      .titleMode(NavigationTitleMode.Mini)
      .hideBackButton(true)
      .menus(this.NavigationMenus())
      .toolbarConfiguration(this.NavigationToolbar())
      .size({ width: '100%', height: '100%' })
    }
    .width('100%')
    .height('100%')
  }
}