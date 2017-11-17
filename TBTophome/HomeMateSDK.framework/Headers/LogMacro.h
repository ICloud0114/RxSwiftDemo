//
//  LogMacro.h
//  Unity-iPhone
//
//  Created by abc on 13-6-24.
//
//

#if 1

#define __SHOW__LOG__

#endif

#ifdef __SHOW__LOG__

/*
 
 DLV3Log(@"LEVEL_3");
 DLV1Log(@"LEVEL_1");
 
 DLLog(LEVEL_3, @"");
 DLLog(LEVEL_1, @"LEVEL_1");
 DLLog(LEVEL_2, @"LEVEL_2");
 DLLog(LEVEL_3, @"LEVEL_3");
 DLLog(LEVEL_4, @"LEVEL_4");
 DLLog(LEVEL_5, @"LEVEL_5");
 DLLog(LEVEL_ALL, @"LEVEL_ALL");
 DLLog(LEVEL_1, @"LEVEL_1");
 DLLog(LEVEL_2, @"LEVEL_2");
 DLLog(LEVEL_3, @"LEVEL_3");
 DLLog(LEVEL_4, @"LEVEL_4");
 DLLog(LEVEL_5, @"LEVEL_5");
 DLLog(LEVEL_ALL, @"LEVEL_ALL");
 
 */
typedef enum {
    
    LEVEL_ALL,
    LEVEL_1,
    LEVEL_2,
    LEVEL_3,
    LEVEL_4,
    LEVEL_5,
    
}LOG_LEVEL;

extern void myLevelLog(int line,char *functname,char *file,LOG_LEVEL level, id formatstring,...);
extern void myLevelLogMessage(int line,const char *functname,const char *file, NSString *message);
//extern void myDDLog(int line,char *functname,char *file, id formatstring,...);

#define DLog(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_ALL,format, ##__VA_ARGS__)
#define DLLog(LEVEL_,format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_,format, ##__VA_ARGS__)

#define DLV1Log(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_1,format, ##__VA_ARGS__)
#define DLV2Log(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_2,format, ##__VA_ARGS__)
#define DLV3Log(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_3,format, ##__VA_ARGS__)
#define DLV4Log(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_4,format, ##__VA_ARGS__)
#define DLV5Log(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_5,format, ##__VA_ARGS__)

//#define DDLog(format,...) myDDLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,format, ##__VA_ARGS__)

//#ifdef HM_LOG
//#undef HM_LOG

#define HM_LOG(format,...) myLevelLog(__LINE__,(char *)__FUNCTION__,(char *)__FILE__,LEVEL_ALL,format, ##__VA_ARGS__)
//#endif

#else

#define HM_LOG(...)
#define DLog(...)
#define DLLog(...)
#define DLV1Log(...)
#define DLV2Log(...)
#define DLV3Log(...)
#define DLV4Log(...)
#define DLV5Log(...)

#endif
