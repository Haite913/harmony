//该文件用于获取数据，从后端获取数据后，用类来存放
//之后可以在其他文件中进行调用


//工作查询页面的数据，从接口文档进行设置

//工作列表详细数据
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

}

//申请工作列表详细数据
export interface ApplyDetailResult {
  id: number | null;
  jobId: number;
  applianceListId: number;
  useId: number;
  name: string;
  major: string;
  classes: string;
  bankCardNumber: string;
  phone: string;
  classNumber: number;
  average: number;
  special: string;
  applianceReason: string;
  academicYear: string;
  unit: string;
  positionTitle: string;
  positionType: string;
  positionLevel: string;
  startWorkDate: string;
  endWorkDate: string;
  workingWeek: string;
  salary: number;
  teacher: string;
  numberLastYear: number;
  applyMonth: number;
  demandMonth: string;
  hireType: string;
  workPlace: string;
  positionDuty: string;
  positionDemand: string;
  requireNumber: number;
  applyNumber: number;
  passNumber: number;
  reviewStatus: number;
  reviewDateTime: string;
  onDutyStatus: number;
  schoolId: number;
  faculty: string;
  grade: string;
  qq: string;
  comments: string;
  commentScore: number;

}

//申请列表
export interface ApplyResult {
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

//学生信息
export interface StudentInfo{
  id:number;
  name:string;
  username:string
  password:string
  major:string
  classes:string
  phone:string
  poorSymbol:boolean
  identity:number
  delFlag:number
  schoolId:number
  faculty:string
  grade:string
  qq:string
  bankCardNumber:string
}

//getById接口，获取工作详情
export interface getById{
  id: number | null;
  academicYear: string;
  unit: string;
  positionTitle: string;
  head: string;
  headPhone: string;
  requireNumber: number;
  workingWeek: string;
  startWorkDate: string;
  endWorkDate: string;
  positionNature: string;
  salary: number;
  positionType: string;
  positionLevel: string;
  teacher: string;
  budget: string;
  numberLastYear: number;
  applicantMonth: number;
  demandMonth: string;
  hireType: string;
  workPlace: string;
  positionDuty: string;
  applicantNumber:number;
  passNumber: number;
  jobNumber: number;
  positionDemand: string;
  startPublicDate: string;
  endPublicDate: string;
  genderRestriction: number;
  gradeRestriction: number;
  poorRestriction: number;
  academyRestriction: number;
  majorRestriction: number;


}

// 提交工作申请所需要的信息
export interface submitJobInfo {
  //工作信息
  academicYear: string;
  applyMonth: number;
  applyNumber: number;
  budget: string;
  comments: string;
  demandMonth: string;
  endWorkDate: string;
  hireType: string;
  // id: number;
  jobId: number;
  numberLastYear: number;
  passNumber: number;
  positionDemand: string;
  positionDuty: string;
  positionLevel: string;
  positionTitle: string;
  positionType: string;
  requireNumber: number;
  salary: number;
  startWorkDate: string;
  teacher: string;
  unit: string;
  username: string;
  workPlace: string;
  workingWeek: string;

  //学生信息
  studentId: number;
  name: string;
  major: string
  classes: string
  phone: string
  poorSymbol: boolean
  identity: number
  delFlag: number
  schoolId: number
  faculty: string
  grade: string
  qq: string
  bankCardNumber: string

}


