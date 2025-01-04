import { router } from '@kit.ArkUI'
import{ http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct ApplyListPage {
  @State index: number = 2
  getData(){
    // 构建请求体
    const username:string = 'test'
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/applianceList/allApply/${username}`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
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
          data: DataContainer; // 或者更具体的类型，取决于你的数据结构
        }
        interface DataContainer {
          code: number;
          msg: string;
          data: ApplyResult[]; // 同样使用可选属性操作符
        }
        interface ApplyResult {
          id: number | null;
          jobId: number;
          positionTitle: string;
          positionType: string;
          startWorkDate: string;
          phone: string;
          academicYear: string;
          onDutyStatus: number;
          reviewStatus: number;
          bankCardNumber: string;
        }

        const applyResult: ApplyResult[] = [];
        // let obj :ResultObject = JSON.parse(data.result.toString())
        if (data.responseCode==200){
          // 请求成功，处理响应数据
          console.info('Result:' + JSON.stringify(data.result));
          console.info('code:' + JSON.stringify(data.responseCode));
          console.info('header:' + JSON.stringify(data.header));
          console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
            // 解析 JSON 字符串为 JavaScript 对象
          const resultObject: ResultObject = JSON.parse(data.result.toString());
          resultObject.data.data.forEach(
            (item: ApplyResult) => {
              console.info(item.positionTitle);
              console.info(item.positionType);
              console.info(item.startWorkDate);
              console.info(item.phone);
              console.info(item.academicYear);
              console.info(item.bankCardNumber);
              console.info(item.jobId.toString());
              console.info(item.onDutyStatus.toString());
              console.info(item.reviewStatus.toString());
            }
          )
          //     // 清空 applyResult 数组以确保没有旧数据残留
          //     applyResult.length = 0;
          //
          //     // 遍历数据并填充 applyResult 数组
          //     positionsData.forEach((position: any) => {
          //       // 将 onDutyStatus 和 reviewStatus 字符串转换为数字类型
          //       const parsedPosition: ApplyResult = {
          //         id: position.id,
          //         jobId: position.jobId,
          //         positionTitle: position.positionTitle,
          //         positionType: position.positionType,
          //         startWorkDate: position.startWorkDate,
          //         phone: position.phone,
          //         academicYear: position.academicYear,
          //         onDutyStatus: parseInt(position.onDutyStatus, 10),
          //         reviewStatus: parseInt(position.reviewStatus, 10),
          //         bankCardNumber: position.bankCardNumber
          //       };
          //
          //       // 添加到 applyResult 数组
          //       applyResult.push(parsedPosition);
          //     });
          //
          //     console.info('applyResult:', applyResult);
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
        Text('申请列表')
          .onAppear(()=>{
            this.getData();
          })

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