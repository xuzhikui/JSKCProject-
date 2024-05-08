//
//  Macros.h
//  SWDatePickerDemo
//
//  Created by hn on 2020/9/11.
//  Copyright © 2020 SW. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#define SystemFontSize(fontsize) [UIFont systemFontOfSize:(fontsize)]

#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0f green:((hex & 0xFF00) >> 8) / 255.0f blue:(hex & 0xFF) / 255.0f alpha:a]


#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE  ((SCREEN_WIDTH > 414) ? (SCREEN_HEIGHT/375.0) : (SCREEN_WIDTH/375.0))
#define Handle(x)     ((x)*SCREEN_SCALE)


/// 自定义文字颜色
#define TitleColor     UIColorFromHEXA(0x333333,1.0)
#define RedText        UIColorFromHEXA(0xFF405B,1.0)
#define lineSColor     UIColorFromHEXA(0xe5e5e5,1.0)

#endif /* Macros_h */
