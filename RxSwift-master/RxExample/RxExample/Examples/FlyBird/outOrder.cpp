#include"encryption.h"
#include <iostream>
#include <string>
using namespace std;

unsigned char orderUserId[USERID_LENGTH]={7,6,5,4,3,2,1,0,15,14,13,12,11,10,9,8,23,22,21,20,19,18,17,16,31,30,29,28,27,26,25,24};
unsigned char orderDeviceId[DEVICEID_LENGTH]={11,10,9,8,7,6,5,4,3,2,1,0};//,15,14,13,12,11,10,9,8,19,18,17,16,23,22,21,20};
unsigned char orderPassword[GROUP_COUNT][MAIN_PASSWORD_LENGTH]={ 
	{0,1,2,3,4,5}, {1,1,2,3,4,5},{2,2,3,4,5,6},{3,2,3,4,5,6},{4,2,3,4,5,6},
{5,2,3,4,5,6},{6,2,3,4,5,6},{7,2,3,4,5,6},{8,2,3,4,5,6},{9,2,3,4,5,6} };	
	
