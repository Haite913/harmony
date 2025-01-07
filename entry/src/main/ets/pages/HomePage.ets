import { router } from '@kit.ArkUI'
import{ http } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit';
import {McLineChart,McPieChart,McBarChart,Options } from '@mcui/mccharts'

// const instance = axios.create({
//   baseURL:'http://localhost:8866',
// })
interface salary{
  name:string;
  value:number;
}

@Entry
@Component
struct HomePage {
  @State data_common: string[] = []
  @State data_request: number[] = []
  @State data_time: number[] = []

  @State data_salary: salary[] = [];

  @State index: number = 0
  // 柱状图1
  @State BarOptions: Options = new Options({})
  // @State BarOptions: Options = new Options({
  //   legend: {
  //     //设置图例的相关样式与功能
  //     top: '10%', //图例距离顶部侧位置
  //     itemWidth: 10, //图形的宽度
  //     itemHeight: 10, //图形的高度
  //     textStyle: {
  //       //文本样式配置
  //       color: '#3C73FF', //字体颜色
  //       fontSize: 30, //字体大小
  //       fontWeight: '800' //字体粗细
  //     }
  //   },
  //   yAxis: {
  //     //设置y轴的相关样式与功能
  //     min:0,
  //     max:3,
  //     interval:0.5,
  //     axisTick: {
  //       //刻度线配置
  //       length: 6, //刻度的长度
  //       lineStyle: {
  //         //刻度线样式
  //         color: '#000000', //线颜色
  //         width: 1 //线宽度
  //       }
  //     },
  //     axisLine: {
  //       //y轴线配置
  //       show: true //显示y轴线
  //     },
  //     splitLine: {
  //       // Y轴分割线配置。
  //       show: true, //显示分割线
  //       lineStyle: {
  //         //轴线样式
  //         color: '#D9D9D9', //线颜色
  //         width: 1 //线宽度
  //       }
  //     },
  //     axisLabel: {
  //       //y轴文本标签样式配置
  //       color: '#999999', //字体颜色
  //       fontSize: 28, //字体大小
  //       fontWeight: '600' //字体粗细
  //     },
  //   },
  //   xAxis: {
  //     axisLabel: {
  //       //X轴文本标签样式配置
  //       color: '#999999', //字体颜色
  //       fontSize: 28, //字体大小
  //       fontWeight: '600' //字体粗线
  //     },
  //     //设置x轴的相关样式与功能
  //     // data: ['市场部', '行政部', '财务部', '销售部']
  //     // data:[]
  //     data:this.data1
  //   },
  //   series: [//设置柱状区的相关样式与功能
  //     {
  //       name: "各部门需求人数", //图例文字
  //       color: '#3C73FF', //图例颜色
  //       // stack: '', //是否显示堆叠柱子
  //       barStyle: {
  //         //柱状样式配置
  //         width: 14, //柱子宽度
  //         color: '#3C73FF', //柱子颜色
  //         barGap: 1 //同系列之间的柱子间隙
  //       },
  //       // data: [1,3,3,2] //数据
  //       // data:[]
  //       data:this.data2
  //     },
  //   ],
  //   tooltip: {
  //     //设置提示层的相关样式与功能
  //     axisPointer: {
  //       //指示器配置项
  //       type: 'line', //指示器类型
  //       lineStyle: {
  //         //提示线样式
  //         color: '#D9D9D9', //线颜色
  //         width: 2, //线宽度
  //         type: 'solid' //线类型
  //       }
  //     },
  //     backgroundColor: '#FFFFFF', //提示框背景颜色
  //     borderColor: '#C4C4C4', //提示框边框颜色
  //     borderWidth: 1, //提示框边框宽度
  //     padding: 6, //提示框内边距
  //     textStyle: {
  //       //文本样式配置
  //       color: '#666666', //字体颜色
  //       fontSize: 10 //字体大小
  //     }
  //   },
  // })
  // 折线图
  @State LineOptions: Options = new Options({})
  // @State LineOptions: Options = new Options({
  //   xAxis: {
  //     //设置X轴的相关样式与功能
  //     data: ['会计师', '市场经理', '行政助理', '行政文员', '销售代表']
  //   },
  //   yAxis: {
  //     min:10,
  //     max:40,
  //     interval:10,
  //     //设置Y轴的相关样式与功能
  //   },
  //   series: [//设置折线区的相关样式与功能
  //     {
  //       name: '各个岗位的每周工作时长',
  //       data: [11, 5, 9, 13, 12]
  //     }
  //   ]
  // })
  // 饼图
  @State PieOptions:Options = new Options({})
  // @State PieOptions: Options = new Options({
  //   //调色盘颜色列表
  //   // color: ['#FAAD14', '#3C73FF', '#52C41A', '#FF4D4F'],
  //   //设置图例的相关样式与功能
  //   legend: {
  //     top: '10%', //图例距离顶部侧位置
  //     itemWidth: 10, //图形的宽度
  //     itemHeight: 10, //图形的高度
  //     // textStyle: {
  //     //   //文本样式配置
  //     //   color: '#ff00b4ff', //字体颜色
  //     //   fontSize: 30, //字体大小
  //     //   fontWeight: '800' //字体粗细
  //     // }
  //   },
  //   series: [
  //     {
  //       // radius: ['45%', '30%'], // 饼图外半径、内半径
  //       // center: ['50%', '30%'], // 饼图中心位置
  //       data: [
  //         { name: '会计师', value: 7000 },
  //         { name: '市场经理', value: 8000 },
  //         { name: '行政助理', value: 5500 },
  //         { name: '行政文员', value: 5500 },
  //         { name: '销售代表', value: 6000 },
  //       ],
  //       labelLine: {
  //         //文本连接线样式配置
  //         length: 10, //连接线1的长度
  //         length2: 30, //连接线2的长度
  //         lineStyle: {
  //           //提示线样式
  //           width: 1, //线宽度
  //           color: '#ffff0000' //线颜色
  //         }
  //       },
  //       label: {
  //         //系列文本标签样式配置
  //         show: true, //是否显示文本标签
  //         fontWeight: '800', //字体粗细
  //         fontFamily: 'sans-serif',
  //         color: '#ffffffff', //字体颜色
  //         position: 'outside', //文本显示位置
  //         fontSize: 30, //字体大小
  //         distanceToLabelLine: 6 //字体与饼状间距
  //       },
  //     }
  //   ],
  //   tooltip: {
  //     //设置提示层的相关样式与功能
  //     axisPointer: {
  //       //指示器配置项
  //       type: 'line', //指示器类型
  //       lineStyle: {
  //         //提示线样式
  //         color: '#D9D9D9', //线颜色
  //         width: 2, //线宽度
  //         type: 'solid' //线类型
  //       }
  //     },
  //     backgroundColor: '#FFFFFF', //提示框背景颜色
  //     borderColor: '#C4C4C4', //提示框边框颜色
  //     borderWidth: 1, //提示框边框宽度
  //     padding: 6, //提示框内边距
  //     textStyle: {
  //       //文本样式配置
  //       color: '#666666', //字体颜色
  //       fontSize: 14 //字体大小
  //     }
  //   },
  // })


  @Builder
  NavigationMenus() { // CustomBuilder类型的菜单栏
      Row() {
        Image($r('app.media.Logo'))
          .size({ width: 65, height: 65 })
          .margin({right:25,bottom:5},)
      }.justifyContent(FlexAlign.Start)
  }

  @Builder
  NavigationToolbar() { // CustomBuilder类型的toolbar
    Row() {
      Column() {
        Image(this.index == 0 ? $r('app.media.home') : $r('app.media.home_gray'))
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
        Image(this.index == 1 ? $r('app.media.work') : $r('app.media.work_gray'))
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
        Image(this.index == 2 ? $r('app.media.apply') : $r('app.media.apply_gray'))
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
        Image(this.index == 3 ? $r('app.media.person') : $r('app.media.person_gray'))
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
    .height(20)
    .alignItems(VerticalAlign.Center)
  }

  async aboutToAppear(): Promise<void> {
    await this.getData_request()
    await this.getData_time()
    await this.getData_salary()
    this.BarOptions = new Options({
      legend: {
        //设置图例的相关样式与功能
        top: '10%', //图例距离顶部侧位置
        itemWidth: 10, //图形的宽度
        itemHeight: 10, //图形的高度
        textStyle: {
          //文本样式配置
          color: 'black', //字体颜色
          fontSize: 30, //字体大小
          fontWeight: '800' //字体粗细
        }
      },
      yAxis: {
        //设置y轴的相关样式与功能
        min:0,
        max:3,
        interval:0.5,
        axisTick: {
          //刻度线配置
          length: 6, //刻度的长度
          lineStyle: {
            //刻度线样式
            color: '#000000', //线颜色
            width: 1 //线宽度
          }
        },
        axisLine: {
          //y轴线配置
          show: true //显示y轴线
        },
        splitLine: {
          // Y轴分割线配置。
          show: true, //显示分割线
          lineStyle: {
            //轴线样式
            color: '#D9D9D9', //线颜色
            width: 1 //线宽度
          }
        },
        axisLabel: {
          //y轴文本标签样式配置
          color: '#999999', //字体颜色
          fontSize: 28, //字体大小
          fontWeight: '600' //字体粗细
        },
      },
      xAxis: {
        axisLabel: {
          //X轴文本标签样式配置
          color: '#999999', //字体颜色
          fontSize: 28, //字体大小
          fontWeight: '600' //字体粗线
        },
        //设置x轴的相关样式与功能
        // data: ['市场部', '行政部', '财务部', '销售部']
        // data:[]
        data:this.data_common
      },
      series: [//设置柱状区的相关样式与功能
        {
          name: "各部门需求人数", //图例文字
          color: '#c13f2f', //图例颜色
          // stack: '', //是否显示堆叠柱子
          barStyle: {
            //柱状样式配置
            width: 14, //柱子宽度
            color: '#c13f2f', //柱子颜色
            barGap: 1 //同系列之间的柱子间隙
          },
          // data: [1,3,3,2] //数据
          // data:[]
          data:this.data_request
        },
      ],
      tooltip: {
        //设置提示层的相关样式与功能
        axisPointer: {
          //指示器配置项
          type: 'line', //指示器类型
          lineStyle: {
            //提示线样式
            color: '#D9D9D9', //线颜色
            width: 2, //线宽度
            type: 'solid' //线类型
          }
        },
        backgroundColor: '#FFFFFF', //提示框背景颜色
        borderColor: '#C4C4C4', //提示框边框颜色
        borderWidth: 1, //提示框边框宽度
        padding: 6, //提示框内边距
        textStyle: {
          //文本样式配置
          color: '#666666', //字体颜色
          fontSize: 10 //字体大小
        }
      },
    })
    this.LineOptions = new Options({
      xAxis: {
        //设置X轴的相关样式与功能
        // data: ['会计师', '市场经理', '行政助理', '行政文员', '销售代表']
        data:this.data_common
      },
      yAxis: {
        min:10,
        max:40,
        interval:10,
        //设置Y轴的相关样式与功能
      },
      series: [//设置折线区的相关样式与功能
        {
          name: '各个岗位的每周工作时长',
          // data: [11, 5, 9, 13, 12]
          data:this.data_time,
          color: '#c13f2f', //图例颜色
          barStyle: {
            //柱状样式配置
            width: 14, //柱子宽度
            color: '#c13f2f', //柱子颜色
            barGap: 1 //同系列之间的柱子间隙
          },
        }
      ]
    })
    this.PieOptions = new Options({
      //调色盘颜色列表
      color: ['#c13f2f', '#C64D3E', '#C65648', '#C56357','#C36C61'],
      //设置图例的相关样式与功能
      legend: {
        top: '10%', //图例距离顶部侧位置
        itemWidth: 10, //图形的宽度
        itemHeight: 10, //图形的高度
        // textStyle: {
        //   //文本样式配置
        //   color: '#ff00b4ff', //字体颜色
        //   fontSize: 30, //字体大小
        //   fontWeight: '800' //字体粗细
        // }
      },
      series: [
        {
          // radius: ['45%', '30%'], // 饼图外半径、内半径
          // center: ['50%', '30%'], // 饼图中心位置
          // data: [
          //   { name: '会计师', value: 7000 },
          //   { name: '市场经理', value: 8000 },
          //   { name: '行政助理', value: 5500 },
          //   { name: '行政文员', value: 5500 },
          //   { name: '销售代表', value: 6000 },
          // ],
          data:this.data_salary,
          labelLine: {
            //文本连接线样式配置
            length: 10, //连接线1的长度
            length2: 30, //连接线2的长度
            lineStyle: {
              //提示线样式
              width: 1, //线宽度
              color: '#ffff0000' //线颜色
            }
          },
          label: {
            //系列文本标签样式配置
            show: true, //是否显示文本标签
            fontWeight: '800', //字体粗细
            fontFamily: 'sans-serif',
            color: '#ffffffff', //字体颜色
            position: 'outside', //文本显示位置
            fontSize: 30, //字体大小
            distanceToLabelLine: 6 //字体与饼状间距
          },
        }
      ],
      tooltip: {
        //设置提示层的相关样式与功能
        axisPointer: {
          //指示器配置项
          type: 'line', //指示器类型
          lineStyle: {
            //提示线样式
            color: '#D9D9D9', //线颜色
            width: 2, //线宽度
            type: 'solid' //线类型
          }
        },
        backgroundColor: '#FFFFFF', //提示框背景颜色
        borderColor: '#C4C4C4', //提示框边框颜色
        borderWidth: 1, //提示框边框宽度
        padding: 6, //提示框内边距
        textStyle: {
          //文本样式配置
          color: '#666666', //字体颜色
          fontSize: 14 //字体大小
        }
      },
    })
  }



  build() {
    Column() {
      Navigation() {
        //代码编写位置
        McBarChart({options:this.BarOptions})
          .height('25%')
          .margin({top:20})

        McLineChart({options:this.LineOptions})
          .height('25%')
          .margin({top:40})

        McPieChart({options:this.PieOptions})
          .height('25%')
          .margin({top:40})


      }
      .title("首页")
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

  onPageShow(): void {
    console.log(this.data_common.toString(),'hahha')
  }

  async getData_request(): Promise<void> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.on('headersReceive', (header) => {});
      httpRequest.request(
        `http://192.168.236.114:8866/ptjs/statistics/eachDepartmentNumbers`,
        {
          method: http.RequestMethod.GET,
          header: {
            'Content-Type': 'application/json'
          },
        },
        (err: BusinessError, data: http.HttpResponse) => {
          if (data.responseCode == 200) {
            interface ResultObj {
              code: number;
              msg: string | null;
              data: object[];
            }

            let departmentData: string[] = [];
            let numberData: number[] = [];
            const resultObject: ResultObj = JSON.parse(data.result.toString());
            resultObject.data.forEach((item) => {
              const department = Object.keys(item)[0];
              const number = item[department] as number;
              departmentData.push(department);
              numberData.push(number);
            });
            console.log(departmentData.toString(), numberData.toString(), '统计各个部门的需求人数');

            this.data_common = departmentData;
            this.data_request = numberData;

            resolve(); // 数据获取成功，解析 Promise
          } else {
            reject(err); // 请求失败，拒绝 Promise
          }
        }
      );
    });
  }
  async getData_time(): Promise<void> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.on('headersReceive', (header) => {});
      httpRequest.request(
        `http://192.168.236.114:8866/ptjs/statistics/eachPositionWorkingHours`,
        {
          method: http.RequestMethod.GET,
          header: {
            'Content-Type': 'application/json'
          },
        },
        (err: BusinessError, data: http.HttpResponse) => {
          if (data.responseCode == 200) {
            interface ResultObj {
              code: number;
              msg: string | null;
              data: object[];
            }

            let departmentData:string[] = []
            let timeData:number[] = []
            const resultObject:ResultObj = JSON.parse(data.result.toString())
            resultObject.data.forEach((item)=>{
              const department = Object.keys(item)[0]
              const time = item[department] as number
              departmentData.push(department)
              timeData.push(time)
            })
            console.log(departmentData.toString(),timeData.toString(),'统计各个岗位的每周工作时长')

            this.data_common = departmentData;
            this.data_time = timeData;

            resolve(); // 数据获取成功，解析 Promise
          } else {
            reject(err); // 请求失败，拒绝 Promise
          }
        }
      );
    });
  }
  async getData_salary(): Promise<void> {
    return new Promise((resolve, reject) => {
      let httpRequest = http.createHttp();
      httpRequest.on('headersReceive', (header) => {});
      httpRequest.request(
        `http://192.168.236.114:8866/ptjs/statistics/eachPositionSalaryLevels`,
        {
          method: http.RequestMethod.GET,
          header: {
            'Content-Type': 'application/json'
          },
        },
        (err: BusinessError, data: http.HttpResponse) => {
          if (data.responseCode == 200) {
            interface ResultObj {
              code: number;
              msg: string | null;
              data: object[];
            }

            interface DepartmentSalary {
              name: string;
              value: number;
            }

            let departmentSalaryData: DepartmentSalary[] = []
            const resultObject: ResultObj = JSON.parse(data.result.toString())
            resultObject.data.forEach((item) => {
              const department = Object.keys(item)[0]
              const salary = item[department] as number
              departmentSalaryData.push({ name: department, value: salary })
            })
            departmentSalaryData.forEach((item)=>{
              console.log(item.name.toString(),item.value,'统计各个岗位的薪资水平')
            })

            this.data_salary = departmentSalaryData

            resolve(); // 数据获取成功，解析 Promise
          } else {
            reject(err); // 请求失败，拒绝 Promise
          }
        }
      );
    });
  }


}