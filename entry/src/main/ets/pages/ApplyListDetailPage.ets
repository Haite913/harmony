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
  @StorageProp('apply_id') apply_id: string = '1'
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
        .margin({right: 170, bottom: 5})
        .onClick(() => {
          router.pushUrl({url: 'pages/ApplyListPage'})
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
        Text('首页')
          .fontSize(16)
          .fontColor(this.index == 0 ? "#c13f2f" : "#8a8a8a")
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
          .fontColor(this.index == 1 ? "#c13f2f" : "#8a8a8a")
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
          .fontColor(this.index == 2 ? "#c13f2f" : "#8a8a8a")
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
          .fontColor(this.index == 3 ? "#c13f2f" : "#8a8a8a")
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

  aboutToAppear(): void {
    console.info("1111")
    this.getData()
  }

  build() {
    Column() {
      Navigation(){
        //代码编写位置
        Button('返 回')
          .width('30%')
          .height(40)
          .backgroundColor(Color.Red)
          .fontSize(18)
          .fontColor(Color.White)
          .onClick(() => {
            router.pushUrl({url:'pages/ApplyListPage'});
          })
          .margin({ top: 10,left:10 })

        //数据
        // 个人信息
        Column() {
          Text("个人信息")
            .fontSize(20)
            .fontColor(Color.Black)

          Row() {
            Text("姓名: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.name)
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          Row() {
            Text("专业: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.major)
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          Row() {
            Text("班级: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.classes)
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          // 其他个人信息...
        }
        .padding({ left: 20 })
        .backgroundColor(Color.White)
        .borderRadius(10)
        .margin({ top: 20 });

        // 申请信息
        Column() {
          Text("申请信息")
            .fontSize(20)
            .fontColor(Color.Black)

          Row() {
            Text("申请原因: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.applianceReason)
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          Row() {
            Text("职位名称: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.positionTitle)
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          // 其他申请信息...
        }
        .padding({ left: 20 })
        .backgroundColor(Color.White)
        .borderRadius(10)
        .margin({ top: 20 });

        // 申请状态
        Column() {
          Text("申请状态")
            .fontSize(20)
            .fontColor(Color.Black)

          Row() {
            Text("审核状态: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.reviewStatus.toString())
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          Row() {
            Text("审核日期: ")
              .fontSize(16)
              .fontColor(Color.Black);
            Text(this.applyDetailResult.reviewDateTime)
              .fontSize(16)
              .fontColor(Color.Gray);
          }
          .margin({ top: 10 });

          // 其他申请状态信息...
        }
        .padding({ left: 20 })
        .backgroundColor(Color.White)
        .borderRadius(10)
        .margin({ top: 20 });
      }
      // .title("申请详情")
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