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




  JobData: GetData.getPageData[] = [
    GetData.createJobData(1, '2023-2024', '销售部', '销售代表', '王五', 3, '全职', '全职', 20, 5),
    GetData.createJobData(2, '2023-2024', '市场部', '市场专员', '张三', 2, '全职', '全职', 15, 3),
    GetData.createJobData(3, '2023-2024', '技术部', '软件工程师', '李四', 5, '全职', '全职', 30, 10),
    GetData.createJobData(4, '2023-2024', '人事部', '人事助理', '赵六', 1, '全职', '全职', 10, 2),
  ]



  build() {
    Column() {
      Navigation(){
        //代码编写位置
        Text('岗位列表')
        Column(){
          List(){
            ForEach(this.JobData,(item: GetData.getPageData) =>{
              //列表里的第一个项目(后面进行循环)
              ListItem(){
                Column(){
                  Row(){
                    Text(item.positionTitle)  //岗位名称
                      .fontSize(18)
                      .margin({left: 20})
                    Text(item.positionNature)                  //岗位性质
                      .fontSize(18)
                      .margin({left: 60})
                  }
                  .height('40%')
                  .width('100%')
                  Row(){
                    Text(item.unit)                    //单位
                      .fontSize(13)
                      .margin({left: 20})
                    Text(item.jobNumber.toString())                          //在岗人数
                      .fontSize(13)
                      .margin({left: 60})
                  }
                  .height('20%')
                  .width('100%')
                  Row(){
                    Text(item.head)                        //负责人
                      .fontSize(18)
                      .margin({left: 20})
                    Text(item.academicYear)                        //学年
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
                // this.getData();
              })
              .border({
                color: Color.Red,
                radius: 10,
                style: BorderStyle.Solid
              })
              .width('90%')
              .backgroundColor(Color.Gray)
              .margin({bottom: 10})
            })

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