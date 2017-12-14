/**
 * \file sm3.h
 * thanks to Xyssl
 * SM3 standards:http://www.oscca.gov.cn/News/201012/News_1199.htm
 * author:goldboar
 * email:goldboar@163.com
 * 2011-10-26
 */

//#include <stdint.h>

#include <stdio.h>
#include <iostream>
#include <string>
using namespace std;

#define GROUP_COUNT               10
#define MAIN_PASSWORD_LENGTH      6 
#define PASSWORD_LENGTH           10 

#define USERID_LENGTH             32
#define DEVICEID_LENGTH           12
#define TIME_LENGTH               10


typedef unsigned char  uint8_t;
typedef unsigned int     uint32_t;
typedef unsigned short uint16_t;

//typedef unsigned int   uintptr_t;

typedef uint8_t  main_pswd[10][6];

#ifndef XYSSL_SM3_H
#define XYSSL_SM3_H
 

/**
 * \brief          SM3 context structure
 */
typedef struct
{
    uint32_t total[2];     /*!< number of bytes processed  */
    uint32_t state[8];     /*!< intermediate digest state  */
    unsigned char buffer[64];   /*!< data block being processed */

    unsigned char ipad[64];     /*!< HMAC: inner padding        */
    unsigned char opad[64];     /*!< HMAC: outer padding        */

}
sm3_context;


//typedef struct
//{
//	 unsigned char  mPassword[10];//用于存储用户在锁端通过按键输入的密码
//	 unsigned char  lenPass;//对应的密码长度
//   unsigned char  mDeviceId[DEVICEID_LENGTH];//设备ID，12字节
//   unsigned char  mTime[TIME_LENGTH];//="2017113016";时间，例为北京时间，暂定10字节，实际测试中可使用UTC时间
//   unsigned char  mUserId[USERID_LENGTH];// = "000102030405060708090a0b0c0d0e0f";	用户ID 32字节
//}
//pswd_input;//锁端输入参数
//
//typedef struct
//{
//	 unsigned char  effective;//判断用户输入密码是否有效，1：有效   0：无效
//	 unsigned char  mPassword[GROUP_COUNT][PASSWORD_LENGTH];//输出的10组密码，可直接用于比对
//	 unsigned char  mHours[2];//有效时长,hour[0]为高字节，hour[1]为低字节
//}
//pswd_output;//输出给锁端的参数


//typedef struct
//{
//	int  mHours;//用于存储有效时间：长期密码默认：8760；单次密码默认：0；限时：根据具体输入确定
//	unsigned char  mDeviceId[DEVICEID_LENGTH];//设备ID，12字节
//	unsigned char  mTime[TIME_LENGTH];//="2017113016";时间，例为北京时间，暂定10字节，实际测试中可使用UTC时间
//	unsigned char  mUserId[USERID_LENGTH];// = "000102030405060708090a0b0c0d0e0f";	用户ID 32字节
//}
//pswd_input;//云端输入参数
//
//typedef struct
//{
//	unsigned char  effective;//判断用户输入密码是否有效，1：有效   0：无效
//	unsigned char  mPassword[GROUP_COUNT][PASSWORD_LENGTH];//输出的10组密码，可直接用于比对
//	unsigned char  mHours[2];//有效时长,hour[0]为高字节，hour[1]为低字节
//}
//pswd_output;//输出给锁端的参数

typedef struct
{
	int  mHours;//用于存储有效时间：长期密码默认：8760；单次密码默认：0；限时：根据具体输入确定
	string  mDeviceId;//设备ID，12字节
	string  mTime;//="2017113016";时间，例为北京时间，暂定10字节，实际测试中可使用UTC时间
	string  mUserId;// = "000102030405060708090a0b0c0d0e0f";	用户ID 32字节
}
pswd_input;//云端输入参数

typedef struct
{
	int  effective;//判断用户输入密码是否有效，1：有效   0：无效
	int  mPassword[GROUP_COUNT][PASSWORD_LENGTH];//输出的10组密码，可直接用于比对
    int len;
}
pswd_output;//输出给锁端的参数


#ifdef __cplusplus
extern "C" {
#endif

/**
 * \brief          SM3 context setup
 *
 * \param ctx      context to be initialized
 */
	
void SystemInit( void );

void sm3_starts( sm3_context *ctx );


/**
 * \brief          SM3 process buffer
 *
 * \param ctx      SM3 context
 * \param input    buffer holding the  data
 * \param ilen     length of the input data
 */
void sm3_update( sm3_context *ctx, unsigned char *input, int ilen );

/**
 * \brief          SM3 final digest
 *
 * \param ctx      SM3 context
 */
void sm3_finish( sm3_context *ctx, unsigned char output[32] );

/**
 * \brief          Output = SM3( input buffer )
 *
 * \param input    buffer holding the  data
 * \param ilen     length of the input data
 * \param output   SM3 checksum result
 */
void sm3( unsigned char *input, int ilen,
           unsigned char output[32]);

/**
 * \brief          Output = SM3( file contents )
 *
 * \param path     input file name
 * \param output   SM3 checksum result
 *
 * \return         0 if successful, 1 if fopen failed,
 *                 or 2 if fread failed
 */
int sm3_file( char *path, unsigned char output[32] );

/**
 * \brief          SM3 HMAC context setup
 *
 * \param ctx      HMAC context to be initialized
 * \param key      HMAC secret key
 * \param keylen   length of the HMAC key
 */
void sm3_hmac_starts( sm3_context *ctx, unsigned char *key, int keylen);

/**
 * \brief          SM3 HMAC process buffer
 *
 * \param ctx      HMAC context
 * \param input    buffer holding the  data
 * \param ilen     length of the input data
 */
void sm3_hmac_update( sm3_context *ctx, unsigned char *input, int ilen );

/**
 * \brief          SM3 HMAC final digest
 *
 * \param ctx      HMAC context
 * \param output   SM3 HMAC checksum result
 */
void sm3_hmac_finish( sm3_context *ctx, unsigned char output[32] );

/**
 * \brief          Output = HMAC-SM3( hmac key, input buffer )
 *
 * \param key      HMAC secret key
 * \param keylen   length of the HMAC key
 * \param input    buffer holding the  data
 * \param ilen     length of the input data
 * \param output   HMAC-SM3 result
 */
void sm3_hmac( unsigned char *key, int keylen,
                unsigned char *input, int ilen,
                unsigned char output[32] );




//void SystemInit( void );

uint32_t get_ULONG_BE(uint32_t n,unsigned char* b,unsigned char i);

//void getNewUserId(unsigned char* input,unsigned char* order,unsigned char* output);
//void getNewDeviceId(string* input,unsigned char* order,string* output);
//void result_10_Group(unsigned char* input,unsigned char order[GROUP_COUNT][MAIN_PASSWORD_LENGTH],unsigned char output[GROUP_COUNT][MAIN_PASSWORD_LENGTH]);
void lockEncryptFunc(pswd_input* input , pswd_output* output);


#ifdef __cplusplus
}
#endif

#endif /* sm3.h */
