import{ http } from '@kit.NetworkKit'
import { router } from '@kit.ArkUI'
import * as GetData from './GetData'
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct JobListPage {
  @State index: number = 1
  @State loadData : boolean = true
  @State jobDetailData: GetData.getById = {
    id: 0,
    academicYear: '',
    unit: '',
    positionTitle: '',
    head: '',
    headPhone: '',
    requireNumber: 0,
    workingWeek: '',
    startWorkDate: '',
    endWorkDate: '',
    positionNature: '',
    salary: 0,
    positionType: '',
    positionLevel: '',
    teacher: '',
    budget: '',
    numberLastYear: 0,
    applicantMonth: 0,
    demandMonth: '',
    hireType: '',
    workPlace: '',
    positionDuty: '',
    applicantNumber: 0,
    passNumber: 0,
    jobNumber: 0,
    positionDemand: '',
    startPublicDate: '',
    endPublicDate: '',
    genderRestriction: 0,
    gradeRestriction: 0,
    poorRestriction: 0,
    academyRestriction: 0,
    majorRestriction: 0
  }
  @State studentInfo: GetData.StudentInfo = {
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
  @StorageProp('Job_Id') Job_Id: number = 0
  @StorageProp('username') username: string = ''

  @Builder NavigationMenus() { // CustomBuilder类型的菜单栏
    Row() {
      Text('<')
        .fontSize(30)
        .size({width: 65, height: 65})
        .margin({right: 170, bottom: 5})
        .onClick(() => {
          router.pushUrl({url: 'pages/JobListPage'})
        })
      Image($r('app.media.Logo'))
        .size({ width: 65, height: 65 })
        .margin({right:25,bottom:5},)
    }.justifyContent(FlexAlign.Start)
  }

  @Builder NavigationToolbar() { // CustomBuilder类型的toolbar
    Row() {
      Column() {
        Image(this.index == 0 ? $r('app.media.layered_image') : $r('app.media.foreground'))
          .size({ width: 25, height: 25 })
        Button('申 请')
          .width('90%')
          .height(50)
          .backgroundColor(Color.Red)
          .fontSize(18)
          .fontColor(Color.White)
          .onClick(() => {
            // 处理登录逻辑，并且在用户选择记住密码时保存密码
            this.postData()

          })

      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)


    }
    .width('100%')
    .height(65)
    .alignItems(VerticalAlign.Center)
  }

  aboutToAppear(): void {
    console.info("1111")
    this.getData()
  }

  //获取数据
  getData(){
    console.log(this.Job_Id.toString())
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/job/${this.Job_Id}`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
      {
        method: http.RequestMethod.GET, // 设置请求方法为GET
        header: {
          'Content-Type': 'application/json' // 设置请求头Content-Type为application/json
        },
      },
      (err: BusinessError, data: http.HttpResponse) => {
        interface ResultObject {
          code: number;
          msg: string;
          data: GetData.getById; // 或者更具体的类型，取决于你的数据结构
        }


        // let obj :ResultObject = JSON.parse(data.result.toString())
        if (data.responseCode==200){
          // 请求成功，处理响应数据
          console.info('Result:' + JSON.stringify(data.result));
          console.info('code:' + JSON.stringify(data.responseCode));
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
          // 解析 JSON 字符串为 JavaScript 对象
          const resultObject: ResultObject = JSON.parse(data.result.toString());
          console.info(resultObject.data.positionTitle)
          this.jobDetailData = resultObject.data                         //将值赋给全局变量

          this.loadData = false;
        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
        }
      }
    );

    interface ResultObject {
      code: number;
      msg: string;
      data: DataContainer; // 或者更具体的类型，取决于你的数据结构
    }
    interface DataContainer {
      code: number;
      msg: string;
      data: GetData.StudentInfo; // 同样使用可选属性操作符
    }

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


          this.studentInfo= resultObject.data
          console.info('poorSymbol:', this.studentInfo.poorSymbol);

        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
        }
      }
    );
  }

  //传输数据
  postData(){
    interface Test{
      username: string,
      id: number,
      comments: string;
    }

    const submitInfo: GetData.submitJobInfo = {
      //工作信息
      academicYear : this.jobDetailData.academicYear,
      applyMonth: this.jobDetailData.applicantMonth,
      applyNumber: this.jobDetailData.applicantNumber,
      budget: this.jobDetailData.budget,
      comments: '',             //必要
      demandMonth: this.jobDetailData.demandMonth,
      endWorkDate: this.jobDetailData.endPublicDate,
      hireType: this.jobDetailData.hireType,
      id: this.Job_Id,                          //必要
      jobId: this.Job_Id,
      numberLastYear: this.jobDetailData.numberLastYear,
      passNumber: this.jobDetailData.passNumber,
      positionDemand: this.jobDetailData.positionDemand,
      positionDuty: this.jobDetailData.positionDuty,
      positionLevel: this.jobDetailData.positionLevel,
      positionTitle: this.jobDetailData.positionTitle,
      positionType: this.jobDetailData.positionType,
      requireNumber: this.jobDetailData.requireNumber,
      salary: this.jobDetailData.salary,
      startWorkDate: this.jobDetailData.startWorkDate,
      teacher: this.jobDetailData.teacher,
      unit: this.jobDetailData.unit,
      username: this.username,                //必要
      workPlace: this.jobDetailData.workPlace,
      workingWeek: this.jobDetailData.workingWeek,
      //学生信息
      studentId: this.studentInfo.id,
      name: this.studentInfo.name,
      major: this.studentInfo.major,
      classes: this.studentInfo.classes,
      phone: this.studentInfo.phone,
      poorSymbol: this.studentInfo.poorSymbol,
      identity: this.studentInfo.identity,
      delFlag: this.studentInfo.delFlag,
      schoolId: this.studentInfo.schoolId,
      faculty: this.studentInfo.faculty,
      grade: this.studentInfo.grade,
      qq: this.studentInfo.qq,
      bankCardNumber: this.studentInfo.bankCardNumber


    }

    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送POST请求
    httpRequest.request(
      "http://192.168.236.114:8866/ptjs/applianceList/apply/submitJobInfo", // 填写HTTP请求的URL地址，替换为你的登录接口URL
      {
        method: http.RequestMethod.POST, // 设置请求方法为POST
        header: {
          'Content-Type': 'application/json' // 设置请求头Content-Type为application/json
        },
        // 将请求体转换为字符串
        extraData: JSON.stringify(submitInfo),
      },
      (err: BusinessError, data: http.HttpResponse) => {
        interface ResultObject {
          code: number;
          msg: string;
          data: object; // 或者更具体的类型，取决于你的数据结构
        }
        let obj :ResultObject = JSON.parse(data.result.toString())
        if (obj.code==0){
          AppStorage.setOrCreate("username",this.username)
          // 请求成功，处理响应数据
          console.info('Result:' + JSON.stringify(data.result));
          console.info('code:' + JSON.stringify(data.responseCode));
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
          // 显示登录成功弹窗
          this.getUIContext().showAlertDialog(
            {
              title: '申请',
              message: '申请成功',
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
          router.pushUrl({url: 'pages/ApplyListPage'})
          httpRequest.destroy();
        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
          // 显示登录失败弹窗
          this.getUIContext().showAlertDialog(
            {
              title: '申请',
              message: '申请失败',
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
    Column() {
      Navigation(){
        Column(){

          // 个人信息
          Column() {
            Row() {
              Text(this.jobDetailData.positionTitle)
                .fontSize(30)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
              Text(this.jobDetailData.salary.toString())
                .fontSize(25)
                .fontColor(Color.Red)
                .fontWeight(FontWeight.Bold)
                .margin({left:60})
            }
            .margin({ top: 0 });

            Row() {
              Image($r("app.media.locate"))
                .size({ width: 20, height: 20 })
              Text(this.jobDetailData.workPlace)
                .fontSize(18)
                .fontColor('#8a8a8a')
                .margin({left:3})
              Image($r("app.media.package"))
                .size({ width: 18, height: 18 })
                .margin({left:20})
              Text(this.jobDetailData.unit)
                .fontSize(18)
                .fontColor('#8a8a8a')
                .margin({left:3})
              Image($r("app.media.hat"))
                .size({ width: 25, height: 25 })
                .margin({left:20})
              Text(this.jobDetailData.positionType)
                .fontSize(18)
                .fontColor('#8a8a8a')
                .margin({left:3})
            }
            .margin({ top: 0 });
          }
          .padding({ left: 0 })
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin({ top: 10 ,bottom:10});

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
                  Text(this.jobDetailData.teacher)
                    .fontSize(18)
                    .fontColor(Color.Black)
                    .fontWeight(FontWeight.Bold)
                }

                Row() {
                  Text("需求人数: ")
                    .fontSize(14)
                    .fontColor('#8a8a8a')
                    .fontWeight(FontWeight.Bold)
                  Text(this.jobDetailData.requireNumber.toString())
                    .fontSize(14)
                    .fontColor('#8a8a8a')
                    .fontWeight(FontWeight.Bold)
                }

                Row() {
                  Text("请求人数: ")
                    .fontSize(14)
                    .fontColor('#8a8a8a')
                    .fontWeight(FontWeight.Bold)
                  Text(this.jobDetailData.applicantNumber.toString())
                    .fontSize(14)
                    .fontColor('#8a8a8a')
                    .fontWeight(FontWeight.Bold)
                }

                Row() {
                  Text("在岗人数: ")
                    .fontSize(14)
                    .fontColor('#8a8a8a')
                    .fontWeight(FontWeight.Bold)
                  Text(this.jobDetailData.passNumber.toString())
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
          Column(){

            // 申请信息
            Row() {
              Text("职位详情")
                .fontSize(20)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
            }
            .padding({ top: 20,right:220 })
            .backgroundColor(Color.White)
            .borderRadius(10)

            Row() {
              Text("任职要求: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3,right:220 })

            }
            .margin({ top: 10 });

            Row() {
              Text(this.jobDetailData.positionDemand)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 5,right:20,left:20 });

            Row() {
              Text("岗位任务: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3,right:220 })
            }
            .margin({ top: 5 });
            Row() {
              Text(this.jobDetailData.positionDuty)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 5,right:20,left:20 });

            Row() {
              Text("开始工作时间: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 })
              Text(this.jobDetailData.startWorkDate)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 10,left:28,right:160 });
            Row() {
              Text("结束工作时间: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 })
              Text(this.jobDetailData.endWorkDate)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 3,left:28,right:160 });
            Row() {
              Text("工作周期: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 })
              Text(this.jobDetailData.workingWeek)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 3,left:28,right:160 });
            Row() {
              Text("学年: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 })
              Text(this.jobDetailData.academicYear)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 3,left:10,right:182 });
          }

          Divider().strokeWidth(2).color('#e6e6e6')
            .margin({top:10})
          Column(){

            Row() {
              Text("个人信息")
                .fontSize(20)
                .fontColor(Color.Black)
                .fontWeight(FontWeight.Bold)
            }
            .padding({ top: 20,right:220 })
            .backgroundColor(Color.White)
            .borderRadius(10)

            Row() {
              Text("姓名: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 ,left:10})
              Text(this.studentInfo.name)
                .fontSize(16)
                .fontColor(Color.Gray);
              Text("电话: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 ,left:50})
              Text(this.studentInfo.phone)
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            Row() {
              Text("专业: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 ,left:5})
              Text(this.studentInfo.major)
                .fontSize(16)
                .fontColor(Color.Gray);
              Text("学院: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 ,left:5})
              Text(this.studentInfo.faculty)
                .fontSize(16)
                .fontColor(Color.Gray);
              Text("学号: ")
                .fontSize(18)
                .fontColor(Color.Black)
                .padding({ top: 3 ,left:5})
              Text(this.studentInfo.schoolId.toString())
                .fontSize(16)
                .fontColor(Color.Gray);
            }
            .margin({ top: 3,left:5,right:182 });
          }
        }
        .size({ width: '100%', height: '100%' })

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