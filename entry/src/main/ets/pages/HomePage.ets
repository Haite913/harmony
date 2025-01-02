import { router } from '@kit.ArkUI'

@Entry
@Component
struct Homepage {
  @State index: number = 0

  @Builder NavigationMenus() { // CustomBuilder类型的菜单栏
    Row() {
      // Image($r('app.media.icon_search'))
      //   .size({ width: 24, height: 24 })
      // Image($r('app.media.icon_add'))
      //   .size({ width: 24, height: 24 })
      //   .margin({ left: 5 })
      // Image($r('app.media.icon_more'))
      //   .size({ width: 24, height: 24 })
      //   .margin({ left: 5 })
    }.justifyContent(FlexAlign.End)
  }

  @Builder NavigationToolbar() { // CustomBuilder类型的toolbar
    Row() {
      Column() {
        // Image(this.index == 0 ? $r('app.media.icon_indexed') : $r('app.media.icon_index'))
        //   .size({ width: 25, height: 25 })
        Text('首页')
          .fontSize(16)
          .fontColor(this.index == 0 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        this.index = 0;
      })

      Column() {
        // Image(this.index == 1 ? $r('app.media.icon_listed') : $r('app.media.icon_list'))
        //   .size({ width: 25, height: 25 })
        Text('列表')
          .fontSize(16)
          .fontColor(this.index == 1 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        // router.pushUrl({url:'pages/LoginPage'})
      })

      Column() {
        // Image(this.index == 2 ? $r('app.media.icon_othered') : $r('app.media.icon_other'))
        //   .size({ width: 25, height: 25 })
        Text('更多')
          .fontSize(16)
          .fontColor(this.index == 2 ? "#28bff1" : "#8a8a8a")
      }
      .alignItems(HorizontalAlign.Center)
      .height('100%')
      .layoutWeight(1)
      .onClick(() => {
        this.index = 2;
      })
    }
    .width('100%')
    .height(50)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      Navigation(){
        Text(this.index == 0 ? "首页" : this.index == 1 ? "列表" : "更多")
          .textAlign(TextAlign.Center)
          .fontSize(30)
          .size({ width: '100%', height: '100%' })
          .backgroundColor('#ffd4e9ee')

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