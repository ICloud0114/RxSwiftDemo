//
//  VihomeDeviceStatus.h
//  Vihome
//
//  Created by Ned on 1/16/15.
//  Copyright (c) 2015 orvibo. All rights reserved.
//

#import "HMBaseModel.h"

/**
 *  新设备入网的时候，假如AppDeviceId为0x0203窗帘控制器的话，在完成了原有的入网流程之后，主机还需要去查询这个设备的属性，如果是对开窗帘的话，设备类型设置为34，如果是卷帘的话，设备类型设置为35，其他设置设备类型为8.
 如果设备类型设置为34、35的话，用户不能再自己去修改设备的图标。如果设备类型是8的话可以在设备类型为3卷帘、4百叶窗、8对开窗帘之间互相切换。
 对于设备类型设置为34、35的窗帘，在设备控制的时候能够精确的指定要打开或者关闭的百分比。控制的过程中窗帘会每隔200ms反馈最新的状态值上来，在APP上面根据状态值动态现实动作的效果。
 */
@interface HMDeviceStatus : HMBaseModel

@property (nonatomic, retain)   NSString *   statusId;
@property (nonatomic, retain)   NSString *   deviceId;

//对于开关型的设备，value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
@property (nonatomic, assign)int                value1;
@property (nonatomic, assign)int                value2;
@property (nonatomic, assign)int                value3;
@property (nonatomic, assign)int                value4;
/**
 *  0--不在线， 1---在线
 */
@property (nonatomic, assign)int                online;
@property (nonatomic, assign)int                alarmType;
@property (nonatomic, assign)int                statusType;

@property (nonatomic, assign)int                serial; // server返回的流水号

@property (nonatomic, strong)HMDevice           *relatedDevice; // 当前状态关联的设备信息,可能为 nil


+ (instancetype)saveProperty:(NSDictionary *)dic;
+ (instancetype)objectWithDeviceId:(NSString *)deviceId uid:(NSString *)uid;
// wifi 插座收到离线消息推送时，把相应状态改掉
+ (BOOL)updateOnlineStatus:(int)status deviceId:(NSString *)deviceId;

/**
 *  rgbw灯的rgb那路是不是开
 * 
 *  @param extAddr rgbw灯
 */
+ (BOOL)rgbwRGBEndPointIsOnWithExtAddr:(HMDevice *)device;

/**
 *  rgbw灯是否为开 （有一路为开则为开）
 *
 *  @param device rgbw灯
 */
+ (BOOL)rgbWIsOnWithExtAddr:(HMDevice *)device;




@end

/**
     开关型的设备: value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
 
     调幅型的设备: value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
                 value2里面填写的为当前的幅度（level属性）值；
                 当主机接收到协调器上传上来的level属性报告的时候，如果level值大于0，则应该把value1的值设置成0，否则设置成1，然后再把设置好的属性值发给客户端和服务器。
     
     RGB灯：value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
           value2里面填写的为当前的幅度（level属性）值；当主机接收到协调器上传上来的level属性报告的时候，如果level值大于0，则应该把value1的值设置成0，否则设置成1，然后再把设置好的属性值发给客户端和服务器。
           value3填写饱和度值，
           value4填写色度值；
     
     色温灯：value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
            value2里面填写的为当前的幅度（level属性）值；当主机接收到协调器上传上来的level属性报告的时候，如果level值大于0，则应该把value1的值设置成0，否则设置成1，然后再把设置好的属性值发给客户端和服务器。
            Value3填写色温值，范围位154～370，154为白色，370为黄色；
     
     华顶夜灯插座：value1填写插座的on/off属性值，0表示状态为开，填1表示状态为关；
                 value2里面填写的夜灯的on/off属性值，0表示状态为开，填1表示状态为关；
                 value3里面填写的光感联动的状态，0表示联动，1表示不联动。
     
     cluster为0x0203的窗帘：value1填写的是窗帘打开的百分比。0表示关，100表示开，其他值表示停；当电机不存在限位点时，手动拉动窗帘或者APP端控制窗帘动作时。电机反馈窗帘value1为255 表示：窗帘正在初始化。
     
     门磁、窗磁：value1填写0表示关闭状态，填写1表示打开状态；
               value3填写0表示低电量，填写1表示正常电量；
               value4填写电量值。
 
     烟感：value1填写0表示没有检测到烟雾，填写1表示检测到烟雾报警；
          value3填写0表示低电量，填写1表示正常电量；
          value4填写电量值。
 
     人体红外：value1填写0表示无报警，填写1表示检测到入侵；
             value2填写1表示入侵的人一直存在，填写0表示没有检测到入侵持续存在；
             value3填写0表示低电量，填写1表示正常电量；
             value4填写电量值。
 
     温湿度传感器：value1填写温度值，
                 value2填写湿度值，
                 value4填写电量值（-1表示此设备不是电池供电的设备）
 
     照度：value1填写传感器上报的测量值MeasuredValue；
         value4填写电量值。
     
     门锁：value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
          value4填写电量值；
     
     kepler：value1里面填写gas浓度值，单位ppm，取值范围300～10000，
             value2填写CO浓度值，单位PPM，取值范围10～1000，包括边界值；
             value3填写0表示低电量，填写1表示正常电量。如果value2为0，表示没有CO检测的功能，APP不需要显示出来。
     
     水浸：value1填写0表示正常，填写1表示报警；
          value3填写0表示低电量，填写1表示正常电量；
          value4填写电量值。
     
     可燃气体报警器：value1填写0表示正常，填写1表示报警；
                   value3填写0表示低电量，填写1表示正常电量；
                   value4填写电量值。
     
     CO报警器：value1填写0表示正常，填写1表示报警；
              value3填写0表示低电量，填写1表示正常电量；
              value4填写电量值。
     
     紧急按钮：value1填写0表示正常，填写1表示报警；
             value3填写0表示低电量，填写1表示正常电量；
             value4填写电量值。
 
     配电箱：value1里面填写on/off属性值，0表示状态为开，填1表示状态为关；
            Value2里边前1bit为功率因素，后2bit为电压，最后一位保留
            Value3电流；
            values4功率

 */



