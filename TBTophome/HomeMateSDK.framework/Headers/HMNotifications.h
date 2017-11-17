//
//  Notifications.h
//  Vihome
//
//  Created by Ned on 1/20/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#ifndef Vihome_Notifications_h
#define Vihome_Notifications_h

/**
 *  网络状态变化通知
 */
static NSString * const NOTIFICATION_NETWORKSTATUS_CHANGE = @"notificationNetworkStatusChange";

static NSString * const APNOTIFICATION_NETWORKSTATUS_CHANGE = @"apnotificationNetworkStatusChange";
/**
 *                                                    网络状态变化时用于通知界面网络故障的通知
 *
 */
static NSString * const NOTIFICATION_NETWORKSTATUS_CHANGE_FOR_BANNER = @"notificationNetworkStatusChangeForBanner";

static NSString * const kNOTIFICATION_AUTO_DISAPPEAR_LOADING = @"auto_disappear_loading"; // loading view 自动消失
static NSString * const kNOTIFICATION_SEARCH_MDNS_RESULT = @"search_mdns_result";         // 搜索mdns后发出通知

/**
 *  登录成功后，或者绑定成功后，显示带有tabbar的主界面
 */

/**
 *  新设备上报接口的通知
 */
static NSString * const kNOTIFICATION_NEW_DEVICE_REPORT = @"new_device_report";

/**
 *  设备属性报告接口
 */
static NSString * const kNOTIFICATION_DEVICE_STATUS_REPORT = @"device_status_report";

/**
 *  设备属性报告接口- device Widget 用
 */
static NSString * const kNOTIFICATION_DEVICE_WIDGET_STATUS_REPORT = @"kNOTIFICATION_DEVICE_WIDGET_STATUS_REPORT";


/**
 设备上线掉线报告通知 （设备widget 会用到）
 */
static NSString * const kNOTIFICATION_DEVICE_WIDGET_ONOFFLINE_REPORT = @"kNOTIFICATION_DEVICE_WIDGET_ONOFFLINE_REPORT";

/**
 *  设备修改房间后刷新主界面设备列表
 */
static NSString * const KNOTIFICATION_DEVICE_LIST_NEED_FRESH = @"device_list_need_fresh";

/**
 *  晾衣架状态上报刷新二级界面
 */
static NSString * const KNOTIFICATION_CLOTHESHORSE_STATUS_REPORT = @"clotherHorse_status_report";

/**
 *  晾衣架倒计时设置上报刷新二级界面
 */
static NSString * const KNOTIFICATION_CLOTHESHORSE_COUNTDOWN_REPORT = @"clothes_status_report";

/**
 *  传感器数据上报
 */
static NSString * const KNOTIFICATION_SENSOR_DATA_REPORT = @"sensor_data_report";

/**
 *  传感器事件上报
 */
static NSString * const KNOTIFICATION_SENSOR_EVENT_REPORT = @"sensor_event_report";

/**
 *  弹框推送
 */
static NSString * const KNOTIFICATION_POST_ALERT_REPORT = @"post_alert_report";

/**
 *  账号切换后刷新数据
 */
static NSString * const KNOTIFICATION_ACCOUNT_SWITCH = @"account_switch";

/**
 *  楼层，房间被增删改后需要发送出来的消息 userInfo需要一致
 
 NSDictionary * userInfo = @{
                                KDataTypeM:@(KDataTypeDelete),
                                KDataObject:(deleteFloor) 
                            };


 */
static NSString * const KNOTIFICATION_FLOOR_AND_ROOM_ADD_EDIT_DELETE_NOTIFICATION = @"floor_and_room_add_edit_delete_notification";


/**
 *  zigbee红外学习上报接口
 */
static NSString * const KNOTIFICATION_DEVICE_IR_LEARN_RESULT = @"device_IR_learn_result";

/**
 *  wifi设备红外上报接口
 */
static NSString * const KNOTIFICATION_DEVICE_IR_UPLOAD = @"device_IR_Upload";
/**
 *  接收到定时执行结果的推送信息
 *
 */
static NSString * const KNOTIFICATION_TIME_PUSH_INFO = @"time_push_info";

/**
 *  接收到倒计时执行结果的推送信息
 *
 */
static NSString * const KNOTIFICATION_COUNTDOWN_PUSH_INFO = @"countdown_push_info";


static NSString * const kNOTIFICATION_LOGIN_SUCCESS = @"login_Succeed";        // 登录成功
static NSString * const kNOTIFICATION_LOGIN_FAILED = @"login_Failed";         // 登录失败
static NSString * const kNOTIFICATION_LOGIN_FINISH = @"login_finish";         // 登录完成（可能失败也可能成功，会携带状态值）
static NSString * const kNOTIFICATION_TO_FIND_DEVICE = @"to_find_device";         // 登录完成（可能失败也可能成功，会携带状态值）
static NSString * const kNOTIFICATION_LOG_OFF = @"log_off";              // 退出登录到登录页
static NSString * const kNOTIFICATION_SCENE_BIND_RESULT = @"scene_bind_result";    // 情景绑定的处理结果

static NSString * const kNOTIFICATION_REMOTE_CONTROL_RESULT = @"remote_bind_result";  // zigbee遥控器绑定的处理结果
static NSString * const kNOTIFICATION_CANCEL_SOCKET_TASK = @"cancel_socket_task";   // 取消socket任务，会断开链接，比如登录时进入后台

/**
 
 从后台进入前台之后同步状态表，读完之后发送消息更新设备状态
 管理员登录之后同步所有数据，读完之后发送消息更新数据
 */
static NSString * const kNOTIFICATION_UPDATE_DEVICE_STATUS = @"update_device_status";

/**
    网关被重置
 */
static NSString * const kNOTIFICATION_GATEWAY_RESET = @"gateway_reset";

/**
 *  收到推送消息时刷新小红点
 */
static NSString * const kNOTIFICATION_REFRESH_UNREAD_MESSAGE = @"refresh_unread_message";

/**
 *  收到倒计时激活、或暂停提醒
 */
static NSString * const kNOTIFICATION_ACTIVE_OR_STOP_COUNTDOWN = @"active_or_stop_countdown";

/**
 *  收到定时或传感器设置开关推送刷新开关状态
 */
static NSString * const kNOTIFICATION_REFRESH_SWUTCH_STATUS = @"refresh_switch_status";

static NSString * const KNOTIFICATION_INVITEFAMILYMEMBERRESULT = @"inviteFamilyMemberResult";

static NSString * const KNOTIFICATION_SEARCHCOCORESULT = @"SeacrhCOCOResult";

static NSString * const KNOTIFICATION_SEARCH_UNBIND_WIFI_DEVICE = @"SearchUnbindWifiDevice";

/**
 *  首页普通设备cell刷新UI
 */
static NSString * const KHomePageRefreshCellNotification = @"HomePageRefreshCellNotification";

/**
 *  传感器列表二级页面设备cell刷新UI
 */
static NSString * const KHomePageSenseListViewNotification = @"KHomePageSenseListViewNotification";

/**
 *  首页传感器cell刷新
 */
static NSString * const KHomePageSenseNotification = @"KHomePageSenseNotification";

/**
 *  首页常用设备cell刷新
 */
static NSString * const KHomePageCommonUseDevicesNotification = @"KHomePageCommonUseDevicesNotification";

/**
 *  刷新首页HMHomePageAlloneControlPanelBaseCell
 */
static NSString * const KHomePageControlPancelCellNotification = @"refreshControlPancelCellNotification";

/**
 *  刷新首页HMHomePageAirConditionControlPanel Cell
 */
static NSString * const KHomePageAirConditionControlPanelCellNotification = @"refreshAirConditionControlPanelCellNotification";

/**
 *  记忆遥控器，重配Allone后获取该Allone旧的数据
 */
static NSString * const KNOTIFICATION_OLD_DATA_FOR_ALLONE = @"KNotificationGetOldDataForAllone";

/**
 *  数据同步完成后发出此通知
 */

static NSString * const KNOTIFICATION_SYNC_TABLE_DATA_FINISH = @"SyncTableDataFinish";

/**
 *  获得城市后发出通知进行定位
 */
static NSString * const KNOTIFICATION_LOCATION_CITY = @"LocationCity";

/**
 *  接收到授权门锁打开的通知之后发送的通知
 */
static NSString * const KNOTIFICATION_DOOR_OPNE = @"door_open";

/**
 *  接收到旧门锁打开的通知之后发送的通知
 */
static NSString * const KNOTIFICATION_OLD_DOORLOCK_OPNE = @"old_doorlock_open";

/**
 *  安防记录按钮小红点显示：
 *  收到（cmd = 82 或 cmd = 113 ）并且 messageType == 1 读messageSecurity查看是否有最新消息
 */
static NSString * const KNOTIFICATION_QUERY_MESSAGE_SECURITY = @"queryMessageSecurityNotification";

/**
 *   获取萤石摄像头token
 */

static NSString * const KGETYSTOKENSUCCESS = @"getYSTokenSuccess";


/**
 *   获取萤石摄像头token
 */

static NSString * const KGETYSTOKENFAIL = @"getYSTokenFail";

/**
 *  发送搜索局域网COCO的通知
 */
static NSString * const KNOTIFICATION_SEARCH_COCO = @"KNOTIFICATION_Search_Coco";

/**
 *  设备被删除的通知
 */
static NSString * const KNOTIFICATION_DEVICEHASBEENREMOVED = @"KNOTIFICATION_DeviceHasBeenRemoved";

/**
 *  修改窗帘类型通知
 */
static NSString * const KNOTIFICATION_MODIFYCURTAINTYPE = @"modifyCurtainType";

/**
 *  天气请求成功或失败的通知
 */
static NSString * const KNOTIFICATION_WEATHERRESULT = @"getWeatherSuccess";

/**
 *  温度传感器选择华氏度或者摄氏度的通知
 */
static NSString * const KNOTIFICATION_TEMPTYPE = @"tempType";

/**
 *  手势密码点击返回发出通知
 */
static NSString * const KNOTIFICATION_GESBACK = @"gesBack";

/**
 *  重设手势密码或者强制退出发出通知
 */
static NSString * const KNOTIFICATION_RESETGESPASSWORD = @"resetGesPassWord";

/**
 *  引导页登陆成功发出通知让引导页消失
 */
static NSString * const KNOTIFICATION_REMOVEGUIDEVIEW = @"removeGuideView";

/**
 *  刷新EPG结束
 *
 */
static NSString * const KNOTIFICATION_REFRESHEPGFINISH = @"KNOTIFICATION_REFRESHEPGFINISH";

/**
 *  绑定第三方账号成功  通知修改UI
 *
 */
static NSString * const KNOTIFICATION_BINDSUCCESS = @"KNOTIFICATION_BINDSUCCESS";

/**
 *  小欧设备升级完后重新启动画面
 *
 */
static NSString * const KNOTIFICATION_XIAOOUUPDATESUCCESS = @"KNOTIFICATION_XIAOOUUPDATESUCCESS";

/**
 *  主机上报更新状态
 */
 static NSString * const KKNOTIFICATION_UPGRADESTATUS = @"KKNOTIFICATION_UPGRADESTATUS";


/**
 *  进入前台后启动小欧成功后发送通知　
 *
 */
static NSString * const KNOTIFICATION_XIAOOUENTERFOREGROUNDSUCCESS = @"KNOTIFICATION_XIAOOUENTERFOREGROUNDSUCCESS";


/**
 *  反馈删除图片发出通知
 *
 */
static NSString * const KNOTIFICATION_ADVICEFEEDBACK = @"KNOTIFICATION_ADVICEFEEDBACK";


/**
 *  弹出通知中心或者接电话发出通知  暂停小欧
 *
 */
static NSString * const KNOTIFICATION_XIAOOUSTOPALLCONNECTTED = @"KNOTIFICATION_XIAOOUSTOPALLCONNECTTED";

/**
 *  更新传感器、门锁等最新消息
 *
 */
static NSString * const KNOTIFICATION_REFRESH_LASTEST_MESSAGE = @"KNOTIFICATION_REFRESH_LASTEST_MESSAGE";

/**
 *  设备控制失败 (将UI恢复原始状态)
 */
static NSString * const kNOTIFICATION_CONTROL_FAIL = @"homepage_control_fail";
/**
 *  楼层增删改通知
 *
 */
static NSString * const KNOTIFICATION_FLOORADDDELETEMODETIFY = @"KNOTIFICATION_FLOORADDDELETEMODETIFY";
/**
 *  房间增删改通知
 *
 */
static NSString * const KNOTIFICATION_ROOMADDDELETEMODETIFY = @"KNOTIFICATION_ROOMADDDELETEMODETIFY";

/**
 *  常用情景控制结果
 */
static NSString * const kNOTIFICATION_COMMON_SCENE_CONTROL_RET = @"kNOTIFICATION_COMMON_SCENE_CONTROL_RET";

/**
 *  清空传感器设备状态记录通知
 */
static NSString * const KNOTIFICATION_DELETE_STATUS_RECORD = @"KNOTIFICATION_DELETE_STATUS_RECORD";

/**
 *  获取CountryCode成功
 */
static NSString * const KNOTIFICATION_UPDATELOCATIONSUCCESS = @"KNOTIFICATION_UPDATELOCATIONSUCCESS";

/**
 *  首页点击房间的通知
 */
static NSString * const KNOTIFICATION_KLICKHOMEPAGEROOM = @"KNOTIFICATION_KLICKHOMEPAGEROOM";

/**
 *  数据上报
 */
static NSString * const KKNOTIFICATION_DATAUPLOAD = @"KNOTIFICATION_DATAUPLOAD";

/**
 *  登录成功后将账号存入数据库时候发出通知
 */
static NSString * const KNOTIFICATION_SAVEACCOUNT = @"KNOTIFICATION_SAVEACCOUNT";


/**
 *  阿里百川反馈获取到未读信息数
 */
static NSString * const kNOTIFICATION_BCFEEDBACK_UNREADCOUNT = @"kNOTIFICATION_BCFEEDBACK_UNREADCOUNT";

/**
 *  设置组成员结果
 *
 */
static NSString * const KNOTIFICATION_SET_GROUP_MEMBER_RESULT = @"KNOTIFICATION_SET_GROUP_MEMBER_RESULT";



/**
 *  家庭管理子账号被主账号删除发出通知
 */
static NSString * const kNOTIFICATION_DELETE_FAMILY_USER = @"kNOTIFICATION_DELETE_FAMILY_USER";


/**
 *  家庭管理子账号加入家庭发出通知
 */
static NSString * const kNOTIFICATION_JOIN_FAMILY = @"kNOTIFICATION_JOIN_FAMILY";


/**
 *  更新 Widget - 情景信息
 */
static NSString * const kNOTIFICATION_WIDGET_SCENE_DATA_RELOAD = @"kNOTIFICATION_WIDGET_SCENE_DATA_RELOAD";

/**
 *  更新 Widget - 安防信息
 */
static NSString * const kNOTIFICATION_WIDGET_SECURITY_DATA_RELOAD = @"kNOTIFICATION_WIDGET_SECURITY_DATA_RELOAD";
/**
 *  更新 Widget - 设备的信息
 */
static NSString * const kNOTIFICATION_NEED_UPDATE_DEVICE_WIDGET_INFO = @"kNOTIFICATION_NEED_UPDATE_DEVICE_WIDGET_INFO";

/**
 *  Widget - 设备信息更新完成
 */
static NSString * const kNOTIFICATION_DEVICE_WIDGET_INFO_UPDATE_FINISH = @"kNOTIFICATION_DEVICE_WIDGET_INFO_UPDATE_FINISH";

/**
 *  家庭管理切换成功发出通知
 */
static NSString * const kNOTIFICATION_FAMILY_SWITCH_SUCCESS = @"kNOTIFICATION_FAMILY_SWITCH_SUCCESS";

/**
 *  发现一个新的中央空调面板
 */
static NSString * const kNOTIFICATION_FIND_CENTER_AIRCONDITIONAL_PANEL = @"kNOTIFICATION_FIND_CENTER_AIRCONDITIONAL_PANEL";



#endif
