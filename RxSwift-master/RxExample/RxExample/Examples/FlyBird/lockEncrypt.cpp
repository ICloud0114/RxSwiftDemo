
#include "encryption.h"
#include <string.h>
#include <stdio.h>
#include <iostream>
#include <string>

extern unsigned char orderUserId[USERID_LENGTH];
extern unsigned char orderDeviceId[DEVICEID_LENGTH];
extern unsigned char orderPassword[GROUP_COUNT][MAIN_PASSWORD_LENGTH];

//void SystemInit( void ){};

static const uint8_t CCrc_uCrc8Table[256] = // CRC8???
{
    0x00, 0x31, 0x62, 0x53, 0xc4, 0xf5, 0xa6, 0x97, 0x88, 0xb9, 0xea, 0xdb, 0x4c, 0x7d, 0x2e, 0x1f,
    0x21, 0x10, 0x43, 0x72, 0xe5, 0xd4, 0x87, 0xb6, 0xa9, 0x98, 0xcb, 0xfa, 0x6d, 0x5c, 0x0f, 0x3e,
    0x73, 0x42, 0x11, 0x20, 0xb7, 0x86, 0xd5, 0xe4, 0xfb, 0xca, 0x99, 0xa8, 0x3f, 0x0e, 0x5d, 0x6c,
    0x52, 0x63, 0x30, 0x01, 0x96, 0xa7, 0xf4, 0xc5, 0xda, 0xeb, 0xb8, 0x89, 0x1e, 0x2f, 0x7c, 0x4d,
    0xe6, 0xd7, 0x84, 0xb5, 0x22, 0x13, 0x40, 0x71, 0x6e, 0x5f, 0x0c, 0x3d, 0xaa, 0x9b, 0xc8, 0xf9,
    0xc7, 0xf6, 0xa5, 0x94, 0x03, 0x32, 0x61, 0x50, 0x4f, 0x7e, 0x2d, 0x1c, 0x8b, 0xba, 0xe9, 0xd8,
    0x95, 0xa4, 0xf7, 0xc6, 0x51, 0x60, 0x33, 0x02, 0x1d, 0x2c, 0x7f, 0x4e, 0xd9, 0xe8, 0xbb, 0x8a, 
    0xb4, 0x85, 0xd6, 0xe7, 0x70, 0x41, 0x12, 0x23, 0x3c, 0x0d, 0x5e, 0x6f, 0xf8, 0xc9, 0x9a, 0xab,
    0xcc, 0xfd, 0xae, 0x9f, 0x08, 0x39, 0x6a, 0x5b, 0x44, 0x75, 0x26, 0x17, 0x80, 0xb1, 0xe2, 0xd3,
    0xed, 0xdc, 0x8f, 0xbe, 0x29, 0x18, 0x4b, 0x7a, 0x65, 0x54, 0x07, 0x36, 0xa1, 0x90, 0xc3, 0xf2,
    0xbf, 0x8e, 0xdd, 0xec, 0x7b, 0x4a, 0x19, 0x28, 0x37, 0x06, 0x55, 0x64, 0xf3, 0xc2, 0x91, 0xa0,
    0x9e, 0xaf, 0xfc, 0xcd, 0x5a, 0x6b, 0x38, 0x09, 0x16, 0x27, 0x74, 0x45, 0xd2, 0xe3, 0xb0, 0x81,
    0x2a, 0x1b, 0x48, 0x79, 0xee, 0xdf, 0x8c, 0xbd, 0xa2, 0x93, 0xc0, 0xf1, 0x66, 0x57, 0x04, 0x35,
    0x0b, 0x3a, 0x69, 0x58, 0xcf, 0xfe, 0xad, 0x9c, 0x83, 0xb2, 0xe1, 0xd0, 0x47, 0x76, 0x25, 0x14, 
    0x59, 0x68, 0x3b, 0x0a, 0x9d, 0xac, 0xff, 0xce, 0xd1, 0xe0, 0xb3, 0x82, 0x15, 0x24, 0x77, 0x46,
    0x78, 0x49, 0x1a, 0x2b, 0xbc, 0x8d, 0xde, 0xef, 0xf0, 0xc1, 0x92, 0xa3, 0x34, 0x05, 0x56, 0x67
}; 

// ??CRC8????. uInitCrc????,?0??,??????????

uint8_t CCrc_GetCrc8( const void *pData, uint32_t uSize)
{    
    uint8_t uCrc ;
    const uint8_t * pBuf;
    
    pBuf = (const uint8_t *)pData;    
    uCrc =  0xff;
    
    while(uSize--)
        uCrc = CCrc_uCrc8Table[uCrc^(*pBuf++)]; 
    return uCrc ^ 0xff; 
}


void getNewUserId(unsigned char* input,unsigned char* order,unsigned char* output)
 {
//	string output="";
	unsigned char i;
 // unsigned char output0[USERID_LENGTH];
   unsigned char crtOrder=0;

  // printf("%s\r\n",input);

	for(i=0;i<USERID_LENGTH;i++)
	{		
		crtOrder=order[i];
		output[i]=input[crtOrder];
	//	printf("order[i]:%d-->",crtOrder);
	//	printf("intput[crtOrder]:%c-->",input[crtOrder]);
	//	printf("output[i]:%c-->\r\n",output[i]);
	}	
//	return output;
 }
 
void getNewDeviceId(unsigned char* input,unsigned char* order,unsigned char* output)
 {	 
	unsigned char i;
  unsigned char crtOrder=0;
 // unsigned char output0[DEVICEID_LENGTH];
	for(i=0;i<DEVICEID_LENGTH;i++)
	{
		crtOrder=order[i];
		output[i]=input[crtOrder];
	}
	//memcpy(output,output0,DEVICEID_LENGTH);
 } 

 
void result_10_Group(unsigned char* input,unsigned char order[GROUP_COUNT][MAIN_PASSWORD_LENGTH],int output[GROUP_COUNT][MAIN_PASSWORD_LENGTH])
{	  
	unsigned char i,j;
  unsigned char crtOrder=0;
	
	for(i=0;i<GROUP_COUNT;i++)
	{
	//	printf("%d:",i);
		for(j=0;j<MAIN_PASSWORD_LENGTH;j++)
		{
			crtOrder=order[i][j];
			output[i][j]=input[crtOrder]%10;

	//		printf("%d",output[i][j]);
		}
	//	printf("\r\n");
	}
 }
 
 //检测时间的有效性，并计算密码长度，获取最终密码
void get_mid_numbers(int hours , int pswd[GROUP_COUNT][MAIN_PASSWORD_LENGTH],pswd_output* output)
 {
	 int i=0;
	 memset(output->mPassword,0,sizeof(output->mPassword));
//	int shang;
	 switch(hours)
	 {
		 case 8760:{//长期，有效时间为8760小时
			 output->len=6;

			 for(i=0;i<GROUP_COUNT;i++)
			 {
				 for (int j=0;j<MAIN_PASSWORD_LENGTH;j++)
				 {
					output->mPassword[i][j]=pswd[i][j];
				 }
			 }
			 output->effective=1;
			 break;
				 }
		 case 0:{ /*单次，有效时间为0，中间一位为 9- 其他位的校验和取个位*/
		 	 int sum;//uint8_t

			 output->len=7;

			 for(i=0;i<GROUP_COUNT;i++)
			 {
				 uint8_t pData[6];			 
				 for (int j=0;j<MAIN_PASSWORD_LENGTH;j++)
				 {
					 pData[j]=pswd[i][j];
				 }
				 sum=9-CCrc_GetCrc8(pData,6)%10;		 
//			 	 memcpy(output->mPassword[i],pswd[i],3);
				output->mPassword[i][0]=pswd[i][0];
				output->mPassword[i][1]=pswd[i][1];
				output->mPassword[i][2]=pswd[i][2];
				output->mPassword[i][3]=sum;
//				 memcpy(output->mPassword[i]+4,pswd[i]+3,3);
				 output->mPassword[i][4]=pswd[i][3];
				 output->mPassword[i][5]=pswd[i][4];
				 output->mPassword[i][6]=pswd[i][5];
			 }	
			 output->effective=1;
	    	 break;		 
		 }		 
		default:{//限时，有效时间根据用户输入确定, 中间第5位为  9- 其他位的校验和取个位

		 	 uint8_t pData[9];			 
			 int sum;
			 int quotient =hours/9;
			 int tenBit =9-quotient/10;
			 int bit =9-quotient%10;
			 int remainder =hours%9;
			 output->len=10;

			 if (hours>744)
			 {
				 output->effective= 0;
				 return;
			 }
			 output->effective=1;

			 for(i=0;i<GROUP_COUNT;i++)
			 {
//				 memcpy(pData,pswd[i],3);
				 pData[0]=pswd[i][0];
				 pData[1]=pswd[i][1];
				 pData[2]=pswd[i][2];
				 pData[3]=tenBit;
				 pData[4]=remainder;
				 pData[5]=bit;
				 //memcpy(pData+5,pswd[i]+3,3);
				 pData[6]=pswd[i][3];
				 pData[7]=pswd[i][4];
				 pData[8]=pswd[i][5];

				 sum=9-CCrc_GetCrc8(pData,9)%10;		

			//	 memcpy(output->mPassword[i],pData,5);
				 for (int j=0;j<5;j++)
					 output->mPassword[i][j]=pData[j];

				 output->mPassword[i][5]=sum;
//				 memcpy(output->mPassword[i]+6,pData+5,4);
				 for (int j=5;j<9;j++)
					 output->mPassword[i][j+1]=pData[j];
			 }		 
			 break;
		}
    }		 
}	 	 

/*****************************************************/
 
void lockEncryptFunc(pswd_input* input , pswd_output* output)
 {
	 unsigned char mStr[64]={0};//存储最终需要加密的内容
	 unsigned char mStrRst[33]={0};//存储SM3加密结果
	 int pswd[GROUP_COUNT][MAIN_PASSWORD_LENGTH]={0};//存储SM3的10组挑选后的6位加密结果
	 unsigned char i=0; 

	 unsigned char mUserId[32];
	 unsigned char mDeviceId[32];

	 
	getNewUserId((unsigned char *)input->mUserId.data(), orderUserId,mUserId);//转换顺序后仍旧存入原变量，不再重新申请存储空间
	 getNewDeviceId((unsigned char *)input->mDeviceId.data(), orderDeviceId,mDeviceId);	

	 memcpy(mStr , mUserId , USERID_LENGTH);	 
	 memcpy(mStr+USERID_LENGTH , mDeviceId,DEVICEID_LENGTH);	
	 memcpy(mStr+USERID_LENGTH+DEVICEID_LENGTH , (unsigned char *)input->mTime.data() , TIME_LENGTH);	

	 sm3((unsigned char *)mStr,USERID_LENGTH+DEVICEID_LENGTH+TIME_LENGTH , mStrRst);	//sm3加密
  	 
	 result_10_Group(mStrRst,orderPassword,pswd);//选取10组
	 get_mid_numbers(input->mHours,pswd,output);	

 }


 
 
 
 
 
