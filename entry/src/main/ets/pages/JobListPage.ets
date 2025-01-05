import{ http } from '@kit.NetworkKit'
import { router } from '@kit.ArkUI'
import * as GetData from './GetData'
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct JobListPage {
  @State index: number = 1
  @State loadData : boolean = true
  @State JobData: GetData.getPageData[] = []

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

  getData(){
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      'http://192.168.236.114:8866/ptjs/job/getAll', // 填写HTTP请求的URL地址，替换为你的登录接口URL
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
          data: GetData.getPageData[]; // 同样使用可选属性操作符
        }

        const applyResult: GetData.getPageData[] = [];
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
            (item: GetData.getPageData, index : number) => {
              this.JobData[index] = item;

              console.info(item.positionTitle);
              console.info(item.positionType);
              console.info(item.academicYear);
              console.info(item.unit);
              console.info(item.academicYear);
              console.info(item.head);
              console.info(item.requireNumber.toString());
              console.info(item.positionNature);
              console.info(item.applicantNumber.toString());
              console.info(item.jobNumber.toString());
            }
          )
           this.loadData = false;
        } else {
          // 请求失败，处理错误
          console.error('error:' + JSON.stringify(err));
          // 取消订阅HTTP响应头事件
          httpRequest.off('headersReceive');
        }
      }
    );
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
              ForEach(this.JobData, (item: GetData.getPageData) => {
                //列表里的第一个项目(后面进行循环)
                ListItem() {
                  Column() {
                    Row() {
                      Text('岗位：'+item.positionTitle)//岗位名称
                        .fontSize(22)
                        .fontWeight(FontWeight.Bold)
                        .margin({ left: 0})
                      Text(item.positionNature)//岗位性质
                        .fontSize(22)
                        .fontWeight(FontWeight.Bold)
                        .margin({ left: 40 })
                    }
                    .height('40%')
                    .width('100%')

                    Row() {
                      Text('部门:'+item.unit)//单位
                        .fontSize(18)
                        .fontColor(Color.Gray)
                        .margin({ left: 0 })
                      Text('在岗人数:'+item.jobNumber.toString())//在岗人数
                        .fontSize(18)
                        .fontColor(Color.Gray)
                        .margin({ left: 60 })
                    }
                    .height('20%')
                    .width('100%')

                    Row() {
                      Text('负责人:'+item.head)//负责人
                        .fontSize(16)
                        .margin({ left: 0})
                        .fontColor(Color.Gray)
                      Text('学年：'+item.academicYear)//学年
                        .fontSize(16)
                        .margin({ left: 30 })
                        .fontColor(Color.Gray)
                    }
                    .height('40%')
                    .width('100%')
                  } //对Colum进行排版
                  .height(130)
                  .margin({ left: 20 })
                  .alignItems(HorizontalAlign.Start)
                }
                .onClick(() => {
                  //跳转到相应的界面
                  // router.pushUrl({url: "pages/HomePage"})
                  // this.getData();
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
      // .onAppear(() => {
      //   this.getData()
      // })
      .title("职位")
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