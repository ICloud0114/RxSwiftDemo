


#ifndef __RGB_FLOAT_HSL_H__
#define __RGB_FLOAT_HSL_H__

#include "stdio.h"

#define HSLMAX		240
#define RGBMAX		255
#define UNDEFINED	(HSLMAX*2/3)


typedef unsigned char  uint8 ; //0 ~ 2^8 - 1
typedef unsigned short uint16; //0 ~ 2^16 - 1
typedef unsigned long  uint32; //0 ~ 2^32 - 1

typedef signed char    int8 ; //0 ~ 2^8 - 1
typedef signed short   int16; //0 ~ 2^16 - 1
typedef signed long    int32; //0 ~ 2^32 - 1

typedef double		color_t;

typedef struct {
    color_t R;
    color_t G;
    color_t B;
} RGB_t;

typedef struct {
    color_t H;
    color_t S;
    color_t L;
} HSL_t;

extern void RGBtoHSL(RGB_t *rgb, HSL_t *hsl);
extern void HSLtoRGB(HSL_t *hsl, RGB_t *rgb);


#endif // __RGB_AND_HSL_H__
