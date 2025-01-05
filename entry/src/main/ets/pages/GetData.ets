//该文件用于获取数据，从后端获取数据后，用类来存放
//之后可以在其他文件中进行调用


//工作查询页面的数据，从接口文档进行设置
export interface  getPageData {
  id: number;             //工作编号
  academicYear: string    //学年
  unit: string;           //单位
  positionTitle: string;  //岗位名称
  head: string            //岗位负责人
  requireNumber: number   //需求人数
  positionNature: string  //岗位性质
  positionType: string    //岗位要求
  applicantNumber: number //申请人数
  jobNumber: number       //在岗人数

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


export function createJobData(id:number, academicYear: string, unit: string, positionTitle: string, head: string,
  requireNumber: number, positionNature: string, positionType: string, applicantNumber:number, jobNumber:number) {
  return ({
    id: id,
    academicYear: academicYear,
    unit: unit,
    positionTitle: positionTitle,
    head: head,
    requireNumber: requireNumber,
    positionNature: positionNature,
    positionType: positionType,
    applicantNumber: applicantNumber,
    jobNumber: jobNumber,
  } as getPageData);
}