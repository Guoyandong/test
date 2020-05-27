//
//  interface.h
//  GQ_****
//
//  Created by Madodg on 2017/11/30.
//  Copyright © 2017年 Madodg. All rights reserved.
//

#ifndef interface_h
#define interface_h

#ifdef Start_LogService
#define LogService YES
#else
#define LogService NO
#endif

#ifdef Show_FPS
#define FPS YES
#else
#define FPS NO
#endif

#define URLAddress \
@{\
@"test":@"http://47.94.22.127:8088",\
@"url2":@"www.gq.com"\
}

#define RequestURL(url) [NSString stringWithFormat:@"%@/%@",URLAddress[URLKEY],url]

#define LoginURL @"linkfree-user/api/user/login"
#define getCodeFromPhone @"linkfree-user/api/user/sms/send"
#define getCodeFromEmail @"linkfree-user/api/email/send/code"
#define resignURL @"linkfree-user/api/user/create"
#define changePassWord @"linkfree-user/api/user/modify/password"
#define UserInfo @"linkfree-user/api/user/info/"
#define contact @"linkfree-user/api/contact/page"
#define deleteContact @"linkfree-user/api/contact/delete"
#define uploadFileToken @"linkfree-file/api/file/temp/token"
#define transactionChose @"linkfree-trans/api/trans/user/list/"
#define transactionUnChose @"linkfree-user/api/contact/trans/searchPage"
#define transactionAddPeople @"linkfree-trans/api/trans/update/member"
#define applicationUnChose @"linkfree-user/api/contact/matter/searchPage"
#define applicationAll @"linkfree-user/api/user/matter/page"
#define applicationAddPeople @"linkfree-trans/api/matters/update/members"
#define applicationChose @"linkfree-trans/api/matters/userList/"
#define addFrend @"linkfree-user/api/contact/create"
#define findID @"linkfree-user/api/user/find/user/id"

/**
 事务：
 常用联系人：事务成员查询接口 和 事务搜索全局联系人
 全部联系人：事务成员全局搜索
 确定按钮：事务更新成员
 事项：
 常用联系人：应用参与人员列表 和 应用搜索全局联系人
 全部联系人：应用选人页面全局搜索（事务里）
 确定按钮：应用更新成员
 */
//事务成员全局搜索
#define transactionAllSearch @"linkfree-user/api/user/global/search"
//应用选人页面全局搜索
#define appSelectPeopleAllSearch @"linkfree-user/api/user/matter/page"
//事务搜索全局联系人
#define transactionSearchAllContract @"linkfree-user/api/contact/trans/searchPage"

//事务相关接口
//>事务列表
#define trans_Page      @"linkfree-trans/api/trans/page"
//>事务创建
#define trans_Create    @"linkfree-trans/api/trans/create"
//>事务隐藏     事务ID,状态类型（1.隐藏 0显示）
#define trans_Hide      @"linkfree-trans/api/trans/hide"
//>事务删除成员接口
#define trans_Remove    @"linkfree-trans/api/trans/remove/member"
//>事务/左滑关闭
#define trans_close     @"linkfree-trans/api/trans/close"
//>事务/左滑恢复
#define trans_restore   @"linkfree-trans/api/trans/restore"

//>事务列表拖拽接口
#define trans_Move      @"linkfree-trans/api/trans/move"
#define trans_unRead    @"linkfree-trans/api/matters/findTransId"


//>选择的事务中是否含有身份
#define trans_query_identity @"linkfree-trans/api/trans/query/identity"




//文件相关接口
//>文件列表接口
#define file_Page       @"linkfree-file/api/file/page"
//>文件/文件夹创建
#define file_CreateFile @"linkfree-file/api/file/create/file"
//>文件/文件夹删除接口
#define file_DeleteFile @"linkfree-file/api/file/delete/file"





#endif /* interface_h */

//测试账号  82287678 / Mdd123123！ ;  zhengkai / kai321
//郭严东  68136965   123456
//张博    55273192   123456
//郑凯    19625625            无法登陆
//马东东   28393572
//72939616  | 123456      | 13641101025 | 佟凯      | 347247652@qq.com |

////参数类型错误 (业务逻辑错误，需要前端业务处理)  PVE0X000000001 这种错误 都是需要客户端处理的
//public final static String  PARAM_VALIDATION_ERROR01 = "PVE0X000000001";
////参数类型错误（参数逻辑验证错误）
//public final static String  PARAM_VALIDATION_ERROR02 = "PVE0X000000002";

#define h5_host @"http://47.94.22.127:8888"

//h5
//>全局搜索页面
#define h5_search @"http://47.94.22.127:8888/linkfree-H5/h5_affair/search.html"
//>事务封面
#define h5_transCover @"http://47.94.22.127:8888/linkfree-H5/h5_affair/identity.html"
//>事务详情
#define h5_transDetail @"http://47.94.22.127:8888/linkfree-H5/h5_affair/itemList.html"


//>发现
#define h5_discovery @"http://47.94.22.127:8888/linkfree-H5/h5_affair/enterance.html"
//>创建
#define h5_createTransaction @"http://47.94.22.127:8888/linkfree-H5/h5_affair/createAffair.html"

#define h5_transactionVertify @"http://47.94.22.127:8888/linkfree-H5/h5_affair/verify.html"



//http://47.94.22.127:8888
//http://47.52.238.58:8888
