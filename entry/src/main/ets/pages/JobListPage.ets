import{ http } from '@kit.NetworkKit'
import { router } from '@kit.ArkUI'
import * as GetData from './GetData'
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct JobListPage {
  @State index: number = 1

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

  getData(){
    // 构建请求体
    // const Jobdata: GetData.getPageData = {
    //   Id: 1,                      //工作编号
    //   academicYear: '2023-2024',  //学年
    //   unit: '销售部',              //单位
    //   positionTitle: '销售代表',    //岗位名称
    //   head: '王五',                //负责人
    //   requireNumber: 3,           //需求人数
    //   positionNature: "全职",
    //   positionType: "全职",
    //   applicantNumber: 20,
    //   jobNumber: 5,
    //
    // };
    // 创建一个HTTP请求任务
    let httpRequest = http.createHttp();
    // 用于订阅HTTP响应头，此接口会比request请求先返回。可以根据业务需要订阅此消息
    httpRequest.on('headersReceive', (header) => {
      console.info('header: ' + JSON.stringify(header));
    });

    // 发送GET请求
    httpRequest.request(
      `http://192.168.236.114:8866/ptjs/job/getAll`, // 填写HTTP请求的URL地址，替换为你的登录接口URL
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
          data: JobResult[]; // 同样使用可选属性操作符
        }
        interface JobResult {
          id: number | null;
          jobId: number;
          positionTitle: string;
          head: string;
          positionNature: string;
          positionType: string;
          requireNumber: number;
          applicantNumber: number;
          jobNumber: number;
          unit: string;
          academicYear: string,
        }
        const jobResult: JobResult[] = [];
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
            (item: JobResult) => {
              console.info(item.positionTitle);
              console.info(item.positionType);
              console.info(item.academicYear);
              console.info(item.jobId?.toString());
              console.info(item.head);
              console.info(item.positionNature);
              console.info(item.unit);
              console.info(item.id?.toString());
              console.info(item.requireNumber.toString());
              console.info(item.applicantNumber.toString());
              console.info(item.jobNumber.toString());
            }
          )
              // 清空 applyResult 数组以确保没有旧数据残留
          jobResult.length = 0;

              // 遍历数据并填充 applyResult 数组
          resultObject.data.data.forEach((job: JobResult) => {
                // 将 onDutyStatus 和 reviewStatus 字符串转换为数字类型
                const jobdata: JobResult = {
                  id: job.id,
                  jobId: job.jobId,
                  positionTitle: job.positionTitle,
                  head: job.head,
                  positionNature: job.positionNature,
                  positionType: job.positionType,
                  requireNumber: job.requireNumber,
                  applicantNumber: job.applicantNumber,
                  jobNumber: job.jobNumber,
                  unit: job.unit,
                  academicYear: job.academicYear,
                };
                // 添加到 applyResult 数组
                jobResult.push(jobdata);
              });
              console.info('jobResult:', jobResult);
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
        Text('岗位列表')
          .onAppear(()=>{
            this.getData()
          })
        Column(){
            List(){
                //列表里的第一个项目(后面进行循环)
              ListItem(){
                Column(){
                  Row(){
                    Text('岗位名称')
                      .fontSize(18)
                      .margin({left:20})
                    Text('岗位性质')
                      .fontSize(18)
                      .margin({left: 60})
                  }
                  .height('40%')
                  .width('100%')
                  Row(){
                    Text('单位')
                      .fontSize(13)
                      .margin({left:20})
                    Text('在岗人数')
                      .fontSize(13)
                      .margin({left:60})
                  }
                  .height('20%')
                  .width('100%')
                  Row(){
                    Text('负责人')
                      .fontSize(18)
                      .margin({left:20})
                    Text('学年')
                      .fontSize(18)
                  }
                  .height('40%')
                  .width('100%')
                }//对Colum进行排版
                .height(130)
                .margin({ left: 20 })
                .alignItems(HorizontalAlign.Start)
              }
              .onClick(() => {
                //跳转到相应的界面
                // router.pushUrl({url: "pages/HomePage"})
                this.getData();
              })

              .border({
                color: Color.Red,
                radius: 10,
                style: BorderStyle.Solid

              })
              .width('90%')
              .backgroundColor(Color.Gray)
          }
          .height('100%')
          .width('100%')
          .margin({top: 5})
          .alignListItem(ListItemAlign.Center)
        }

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