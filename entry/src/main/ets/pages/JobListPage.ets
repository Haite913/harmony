import { router } from '@kit.ArkUI'
import {getPageData} from './GetData'

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

  data: getPageData = {
    jobId: 1,
    onDustyStatus: 'string',
    pageNumber: 2,
    pageSize: 2,
    positionTitle: 'string',
    reviewStatus: 'string',
    unit: 'string',
    userName: 'string'

  };


  build() {
    Column() {
      Navigation(){
        //代码编写位置
        // Text('岗位列表')
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

              })

              //列表里第二个项目

          }
          .height('100%')
          .width('100%')
          .align(Alignment.Top)
          .margin({top: 5})
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