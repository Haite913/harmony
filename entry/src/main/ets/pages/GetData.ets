//该文件用于获取数据，从后端获取数据后，用类来存放
//之后可以在其他文件中进行调用


//工作查询页面的数据，从接口文档进行设置
export interface  getPageData {
  jobId: number;
  onDustyStatus: string;
  pageNumber: number;
  pageSize: number;
  positionTitle: string;
  reviewStatus: string;
  unit: string;
  userName: string;

  // constructor(jobId: number, onDustyStatus: string, pageNumber:number, pageSize: number, positionTitle: string,
  //   reviewStatus: string, unit: string, userName: string) {
  //   this.jobId = jobId;
  //   this.onDustyStatus = onDustyStatus;
  //   this.pageNumber = pageNumber;
  //   this.pageSize = pageSize;
  //   this.positionTitle = positionTitle;
  //   this.reviewStatus = reviewStatus;
  //   this.unit = unit;
  //   this.userName = userName;
  // }
}
