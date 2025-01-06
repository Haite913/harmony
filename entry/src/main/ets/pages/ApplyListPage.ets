import { router } from '@kit.ArkUI'
import{ http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit';
import {ApplyResult} from './GetData'

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

@Entry
@Component
struct ApplyListPage {
  @State index: number = 2
  @StorageProp('username') username: string = 'test'
  @State applyResult: ApplyResult[] = [];
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
      `http://192.168.236.114:8866/ptjs/applianceList/allApply/${this.username}`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
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
              // 清空 applyResult 数组以确保没有旧数据残留
              this.applyResult.length = 0;

              // 遍历数据并填充 applyResult 数组
              resultObject.data.data.forEach((item: ApplyResult) => {
                // 将 onDutyStatus 和 reviewStatus 字符串转换为数字类型
                  const applyPosition: ApplyResult = {
                    id: item.id,
                    jobId: item.jobId,
                    positionTitle: item.positionTitle,
                    positionType: item.positionType,
                    startWorkDate: item.startWorkDate,
                    phone: item.phone,
                    academicYear: item.academicYear,
                    onDutyStatus: item.onDutyStatus,
                    reviewStatus: item.reviewStatus,
                    bankCardNumber: item.bankCardNumber
                  }
                  this.applyResult.push(applyPosition);
              });
              this.loadData = false;
              console.info('applyResult:', this.applyResult);
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
        // Text('岗位列表')
        //   .fontSize(30)
        //   .fontWeight(FontWeight.Bold)
        //   .fontColor(Color.Red)
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
            List() {
              ForEach(this.applyResult, (item: ApplyResult) => {
                //列表里的第一个项目(后面进行循环)
                ListItem() {
                  Column() {
                    Row() {
                      Text('岗位：'+item.positionTitle)//岗位名称
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .margin({ left: 0})
                      Text(item.positionType)//岗位类型
                        .fontColor("#c13f2f")
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .margin({ left: 40 })
                    }
                    .height('40%')
                    .width('100%')

                    Row() {
                      Text('学年:'+item.academicYear)//学年
                        .fontSize(16)
                        .margin({ left: 0 })
                        .fontColor(Color.Gray)
                      Text('开始日期:'+item.startWorkDate)//工作开始日期
                        .fontSize(16)
                        .fontColor(Color.Gray)
                        .margin({ left: 10 })
                    }
                    .height('20%')
                    .width('100%')

                    Row() {
                      Text('联系电话:'+item.phone)//联系电话
                        .fontSize(16)
                        .margin({ left: 0})
                        .fontColor(Color.Gray)
                      if(item.reviewStatus==0){
                        Text('审核状态:未审核')//审核状态
                          .fontSize(18)
                          .fontColor(Color.Orange)
                          .margin({ left: 10 })
                      }else if(item.reviewStatus==1){
                        Text('审核状态:已通过')//审核状态
                          .fontSize(18)
                          .fontColor(Color.Green)
                          .margin({ left: 10 })
                      }else if(item.reviewStatus==2){
                        Text('审核状态:未通过')//审核状态
                          .fontSize(18)
                          .fontColor(Color.Red)
                          .margin({ left: 10 })
                      }

                    }
                    .height('40%')
                    .width('100%')
                  } //对Colum进行排版
                  .height(130)
                  .margin({ left: 20 })
                  .alignItems(HorizontalAlign.Start)
                }
                .onClick(() => {
                  console.info(item.id?.toString());
                  AppStorage.setOrCreate("apply_id",item.id)
                  router.pushUrl({url: "pages/ApplyListDetailPage"})
                })
                .border({
                  color: Color.Red,
                  radius: 10,
                  style: BorderStyle.Solid
                })
                .width('90%')
                .backgroundColor('#fef1eb')
                .margin({ bottom: 10 })
              })

            }
            .height('100%')
            .width('100%')
            .margin({ top: 5 })
            .alignListItem(ListItemAlign.Center)
          }
        }
      }
      .title("申请")
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