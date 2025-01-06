import { router } from '@kit.ArkUI'
import{ http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit';
import {ApplyDetailResult} from './GetData'

interface ResultObject {
  code: number;
  msg: string;
  data: DataContainer; // 或者更具体的类型，取决于你的数据结构
}
interface DataContainer {
  code: number;
  msg: string;
  data: ApplyDetailResult; // 同样使用可选属性操作符
}


@Entry
@Component
struct ApplyListPage {
  @State index: number = 2
  @State applyDetailResult: ApplyDetailResult = {
    id : null,
    jobId : 0,
    applianceListId : 0,
    useId : 0,
    name : "",
    major : "",
    classes : "",
    bankCardNumber : "",
    phone : "",
    classNumber : 0,
    average : 0,
    special : "",
    applianceReason : "",
    academicYear : "",
    unit : "",
    positionTitle : "",
    positionType : "",
    positionLevel : "",
    startWorkDate : "",
    endWorkDate : "",
    workingWeek : "",
    salary : 0,
    teacher : "",
    numberLastYear : 0,
    applyMonth : 0,
    demandMonth : "",
    hireType : "",
    workPlace : "",
    positionDuty : "",
    positionDemand : "",
    requireNumber : 0,
    applyNumber : 0,
    passNumber : 0,
    reviewStatus : 0,
    reviewDateTime : "",
    onDutyStatus : 0,
    schoolId : 0,
    faculty : "",
    grade : "",
    qq : "",
    comments : "",
    commentScore : 0,
  };
  @State loadData : boolean = true
  @StorageProp('apply_id') apply_id: string = ''



  getData(){
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/applianceList/detail/${this.apply_id}`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
      {
        method: http.RequestMethod.GET, // 设置请求方法为GET
        header: {
          'Content-Type': 'application/json' // 设置请求头Content-Type为application/json
        },
      },
      (err: BusinessError, data: http.HttpResponse) => {
        // let obj :ResultObject = JSON.parse(data.result.toString())
        if (data.responseCode==200){
          // 请求成功，处理响应数据
          console.info('Result:' + JSON.stringify(data.result));
          console.info('code:' + JSON.stringify(data.responseCode));
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
          // 解析 JSON 字符串为 JavaScript 对象
          const resultObject: ResultObject = JSON.parse(data.result.toString());
          this.applyDetailResult.id = resultObject.data.data.id;
          this.applyDetailResult.jobId = resultObject.data.data.jobId;
          this.applyDetailResult.applianceListId = resultObject.data.data.applianceListId;
          this.applyDetailResult.useId = resultObject.data.data.useId;
          this.applyDetailResult.name = resultObject.data.data.name;
          this.applyDetailResult.major = resultObject.data.data.major;
          this.applyDetailResult.classes = resultObject.data.data.classes;
          this.applyDetailResult.bankCardNumber = resultObject.data.data.bankCardNumber;
          this.applyDetailResult.phone = resultObject.data.data.phone;
          this.applyDetailResult.classNumber = resultObject.data.data.classNumber;
          this.applyDetailResult.average = resultObject.data.data.average;
          this.applyDetailResult.special = resultObject.data.data.special;
          this.applyDetailResult.applianceReason = resultObject.data.data.applianceReason;
          this.applyDetailResult.academicYear = resultObject.data.data.academicYear;
          this.applyDetailResult.unit = resultObject.data.data.unit;
          this.applyDetailResult.positionTitle = resultObject.data.data.positionTitle;
          this.applyDetailResult.positionType = resultObject.data.data.positionType;
          this.applyDetailResult.positionLevel = resultObject.data.data.positionLevel;
          this.applyDetailResult.startWorkDate = resultObject.data.data.startWorkDate;
          this.applyDetailResult.endWorkDate = resultObject.data.data.endWorkDate;
          this.applyDetailResult.workingWeek = resultObject.data.data.workingWeek;
          this.applyDetailResult.salary = resultObject.data.data.salary;
          this.applyDetailResult.teacher = resultObject.data.data.teacher;
          this.applyDetailResult.numberLastYear = resultObject.data.data.numberLastYear;
          this.applyDetailResult.applyMonth = resultObject.data.data.applyMonth;
          this.applyDetailResult.demandMonth = resultObject.data.data.demandMonth;
          this.applyDetailResult.hireType = resultObject.data.data.hireType;
          this.applyDetailResult.workPlace = resultObject.data.data.workPlace;
          this.applyDetailResult.positionDuty = resultObject.data.data.positionDuty;
          this.applyDetailResult.positionDemand = resultObject.data.data.positionDemand;
          this.applyDetailResult.requireNumber = resultObject.data.data.requireNumber;
          this.applyDetailResult.applyNumber = resultObject.data.data.applyNumber;
          this.applyDetailResult.passNumber = resultObject.data.data.passNumber;
          this.applyDetailResult.reviewStatus = resultObject.data.data.reviewStatus;
          this.applyDetailResult.reviewDateTime = resultObject.data.data.reviewDateTime;
          this.applyDetailResult.onDutyStatus = resultObject.data.data.onDutyStatus;
          this.applyDetailResult.schoolId = resultObject.data.data.schoolId;
          this.applyDetailResult.faculty = resultObject.data.data.faculty;
          this.applyDetailResult.grade = resultObject.data.data.grade;
          this.applyDetailResult.qq = resultObject.data.data.qq;
          this.applyDetailResult.comments = resultObject.data.data.comments;
          this.applyDetailResult.commentScore = resultObject.data.data.commentScore;
          console.info('1111')
          this.loadData=false
        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
        }
      }
    );
  }

  @Builder NavigationMenus() { // CustomBuilder类型的菜单栏

    Row() {
      Text('<')
        .fontSize(30)
        .size({width: 65, height: 65})
        .margin({right: 10, bottom: 5})
        .onClick(() => {
          router.pushUrl({url: 'pages/ApplyListPage'})
        })
      if(this.applyDetailResult.reviewStatus==0){
        Text('审核状态:未审核')//审核状态
          .fontSize(18)
          .fontColor(Color.Orange)
          .margin({ right: 30 })
      }else if(this.applyDetailResult.reviewStatus==1){
        Text('审核状态:已通过')//审核状态
          .fontSize(18)
          .fontColor(Color.Green)
          .margin({ right: 30 })
      }else if(this.applyDetailResult.reviewStatus==2){
        Text('审核状态:未通过')//审核状态
          .fontSize(18)
          .fontColor(Color.Red)
          .margin({ right: 30 })
      }
      Image($r('app.media.Logo'))
        .size({ width: 65, height: 65 })
        .margin({right:25,bottom:5},)
    }.justifyContent(FlexAlign.Start)
  }

  @Builder NavigationToolbar() { // CustomBuilder类型的toolbar
    Row() {
      Button('撤 回 申 请')
        .width('90%')
        .height(50)
        .backgroundColor(Color.Red)
        .fontSize(18)
        .fontColor(Color.White)
        .onClick(() => {
          // 创建一个HTTP请求任务
          let httpRequest = http.createHttp();
          // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
          httpRequest.on('headersReceive', (header) => {
            console.info('header: ' + JSON.stringify(header));
          });

          // 发送GET请求
          httpRequest.request(
            `http://192.168.236.114:8866/ptjs/applianceList/apply/${this.applyDetailResult.id}`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
            {
              method: http.RequestMethod.DELETE, // 设置请求方法为GET
              header: {
                'Content-Type': 'application/json' // 设置请求头Content-Type为application/json
              },
            },
            (err: BusinessError, data: http.HttpResponse) => {
              // let obj :ResultObject = JSON.parse(data.result.toString())
              if (data.responseCode==200){
                // 请求成功，处理响应数据
                // 显示登录成功弹窗
                this.getUIContext().showAlertDialog(
                  {
                    title: '撤销申请',
                    message: '撤销成功',
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
                  })
                  router.pushUrl({url: "pages/ApplyListPage"})
              } else {
                // 请求失败，处理错误
                console.error('error:' + JSON.stringify(err));
                // 取消订阅HTTP响应头事件
                httpRequest.off('headersReceive');
              }
            }
          );

        })
        .margin({ top: 20 ,left:18 });

    }
    .width('100%')
    .height(40)
    .alignItems(VerticalAlign.Center)
  }

  aboutToAppear(): void {
    console.info("1111")
    this.getData()
  }

  build() {
    Column() {
      Navigation(){
        if (this.loadData) {
          // 显示加载提示
          Column(){
            Text('请稍等，数据加载中...')
              .fontSize(30)
              .fontColor(Color.Black)
              .width('100%')
              .height('100%')
          }
          .alignItems(HorizontalAlign.Center)
        } else {
          Column() {

            // 个人信息
            Column() {
              Row() {
                Text(this.applyDetailResult.positionTitle)
                  .fontSize(30)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
                Text(this.applyDetailResult.salary.toString())
                  .fontSize(25)
                  .fontColor(Color.Red)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 60 })
              }
              .margin({ top: 0 });

              Row() {
                Image($r("app.media.locate"))
                  .size({ width: 20, height: 20 })
                Text(this.applyDetailResult.workPlace)
                  .fontSize(18)
                  .fontColor('#8a8a8a')
                  .margin({ left: 3 })
                Image($r("app.media.package"))
                  .size({ width: 18, height: 18 })
                  .margin({ left: 20 })
                Text(this.applyDetailResult.unit)
                  .fontSize(18)
                  .fontColor('#8a8a8a')
                  .margin({ left: 3 })
                Image($r("app.media.hat"))
                  .size({ width: 25, height: 25 })
                  .margin({ left: 20 })
                Text(this.applyDetailResult.positionType)
                  .fontSize(18)
                  .fontColor('#8a8a8a')
                  .margin({ left: 3 })
              }
              .margin({ top: 0 });
            }
            .padding({ left: 0 })
            .backgroundColor(Color.White)
            .borderRadius(10)
            .margin({ top: 10, bottom: 10 });

            Divider().strokeWidth(2).color('#e6e6e6')
            Column() {
              Row() {
                Image($r("app.media.head"))
                  .size({ width: 70, height: 70 })
                  .margin({ left: 0 })
                Column() {
                  Row() {
                    Text("负责老师: ")
                      .fontSize(18)
                      .fontColor(Color.Black)
                      .fontWeight(FontWeight.Bold)
                    Text(this.applyDetailResult.teacher)
                      .fontSize(18)
                      .fontColor(Color.Black)
                      .fontWeight(FontWeight.Bold)
                  }

                  Row() {
                    Text("需求人数: ")
                      .fontSize(14)
                      .fontColor('#8a8a8a')
                      .fontWeight(FontWeight.Bold)
                    Text(this.applyDetailResult.requireNumber.toString())
                      .fontSize(14)
                      .fontColor('#8a8a8a')
                      .fontWeight(FontWeight.Bold)
                  }

                  Row() {
                    Text("请求人数: ")
                      .fontSize(14)
                      .fontColor('#8a8a8a')
                      .fontWeight(FontWeight.Bold)
                    Text(this.applyDetailResult.applyNumber.toString())
                      .fontSize(14)
                      .fontColor('#8a8a8a')
                      .fontWeight(FontWeight.Bold)
                  }

                  Row() {
                    Text("在岗人数: ")
                      .fontSize(14)
                      .fontColor('#8a8a8a')
                      .fontWeight(FontWeight.Bold)
                    Text(this.applyDetailResult.passNumber.toString())
                      .fontSize(14)
                      .fontColor('#8a8a8a')
                      .fontWeight(FontWeight.Bold)
                  }

                }
                .margin({ left: 40 })
              }
              .margin({ top: 20 });
            }

            Divider().strokeWidth(1).color('#e6e6e6')
              .margin({ top: 10 });
            Column() {

              // 申请信息
              Row() {
                Text("职位详情")
                  .fontSize(20)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
              }
              .padding({ top: 20, right: 220 })
              .backgroundColor(Color.White)
              .borderRadius(10)

              Row() {
                Text("任职要求: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, right: 220 })

              }
              .margin({ top: 10 });

              Row() {
                Text(this.applyDetailResult.positionDemand)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 5, right: 20, left: 20 });

              Row() {
                Text("岗位任务: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, right: 220 })
              }
              .margin({ top: 5 });

              Row() {
                Text(this.applyDetailResult.positionDuty)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 5, right: 20, left: 20 });

              Row() {
                Text("开始工作时间: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3 })
                Text(this.applyDetailResult.startWorkDate)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 10, left: 28, right: 160 });

              Row() {
                Text("结束工作时间: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3 })
                Text(this.applyDetailResult.endWorkDate)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 3, left: 28, right: 160 });

              Row() {
                Text("工作周期: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3 })
                Text(this.applyDetailResult.workingWeek)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 3, left: 28, right: 160 });

              Row() {
                Text("学年: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3 })
                Text(this.applyDetailResult.academicYear)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 3, left: 10, right: 182 });
            }

            Divider().strokeWidth(2).color('#e6e6e6')
              .margin({ top: 10 })
            Column() {

              Row() {
                Text("个人信息")
                  .fontSize(20)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
              }
              .padding({ top: 20, right: 220 })
              .backgroundColor(Color.White)
              .borderRadius(10)

              Row() {
                Text("姓名: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, left: 10 })
                Text(this.applyDetailResult.name)
                  .fontSize(16)
                  .fontColor(Color.Gray);
                Text("电话: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, left: 50 })
                Text(this.applyDetailResult.phone)
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }

              Row() {
                Text("专业: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, left: 5 })
                Text(this.applyDetailResult.major)
                  .fontSize(16)
                  .fontColor(Color.Gray);
                Text("学院: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, left: 5 })
                Text(this.applyDetailResult.faculty)
                  .fontSize(16)
                  .fontColor(Color.Gray);
                Text("学号: ")
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .padding({ top: 3, left: 5 })
                Text(this.applyDetailResult.schoolId.toString())
                  .fontSize(16)
                  .fontColor(Color.Gray);
              }
              .margin({ top: 3, left: 5, right: 182 });
            }
          }
          .size({ width: '100%', height: '100%' })
        }
      }
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