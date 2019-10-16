///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/10/18
//
/// @file    l_type.h
/// @brief   基础数据类型定义:win,linux,ios,android,emscripten
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2018/10/18 0.1  创建文件
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_TYPE_H__
#define __L_TYPE_H__

/*
    8,16,32,64 基础数据定义
    __L_WIN32__,        __L_WIN64__,        // x86
    __L_LINUX32__,      __L_LINUX64__,      // x86
    __L_LINUX32_ARM__,  __L_LINUX64_ARM__,  // arm
    __L_IOS__,                              // ios
    __L_ANDROID__,                          // android

    NDEBUG,                                 // 发行版本
*/
#if defined(__L_WIN32__) || defined(__L_WIN64__)
    #ifndef __L_WIN__
        #define __L_WIN__
    #endif
#elif defined(__L_LINUX32__) || defined(__L_LINUX64__) || defined(__L_LINUX32_ARM__) || defined(__L_LINUX64_ARM__)
    #ifndef __L_LINUX__    
        #define __L_LINUX__
    #endif
#elif defined(__L_IOS__) || defined(__L_ANDROID__)
    #ifndef __L_LINUX__    
        #define __L_LINUX__
    #endif
#elif defined(__L_EMCC__)
    #ifndef __L_LINUX__    
        #define __L_LINUX__
    #endif
#else
    #error No Platform
#endif

#if defined(__L_WIN32__) || defined(__L_LINUX32__) || defined(__L_LINUX32_ARM__) || defined(__L_EMCC__)
    typedef unsigned char           bool8;
    typedef char                    int8;
    typedef unsigned char           uint8;
    typedef unsigned short          bool16;
    typedef short                   int16;
    typedef unsigned short          uint16;
    typedef int                     int32;
    typedef unsigned int            uint32;
    typedef unsigned int            bool32;
    typedef long long               int64;
    typedef unsigned long long      uint64;

    typedef int                     bool_t;
    typedef int                     int_t;          //整型,随机器字长变化
    typedef unsigned int            uint_t;         //无符号整型,随机器字长变化
    typedef long                    long_t;         //整型,随机器字长变化
    typedef unsigned long           ulong_t;        //整型,随机器字长变化
#elif defined(__L_WIN64__) || defined(__L_LINUX64__) || defined(__L_LINUX64_ARM__)
    typedef unsigned char           bool8;
    typedef char                    int8;
    typedef unsigned char           uint8;
    typedef unsigned short          bool16;
    typedef short                   int16;
    typedef unsigned short          uint16;
    typedef int                     int32;
    typedef unsigned int            uint32;
    typedef unsigned int            bool32;
    typedef long long               int64;
    typedef unsigned long long      uint64;

    typedef long long               bool_t;
    typedef long long               int_t;      //整型, 随机器字长变化
    typedef unsigned long long      uint_t;     //无符号整型, 随机器字长变化
    typedef long long               long_t;     //整型, 随机器字长变化
    typedef unsigned long long      ulong_t;    //整型, 随机器字长变化
#elif defined(__L_IOS__) || defined(__L_ANDROID__)
    typedef unsigned char           bool8;
    typedef char                    int8;
    typedef unsigned char           uint8;
    typedef unsigned short          bool16;
    typedef short                   int16;
    typedef unsigned short          uint16;
    typedef int                     int32;
    typedef unsigned int            uint32;
    typedef unsigned int            bool32;
    typedef long long               int64;
    typedef unsigned long long      uint64;

    typedef long long               bool_t;
    typedef long long               int_t;      //整型, 随机器字长变化
    typedef unsigned int            uint_t;     //无符号整型, 随机器字长变化
    typedef long long               long_t;     //整型, 随机器字长变化
    typedef unsigned int            ulong_t;    //整型, 随机器字长变化
#else
    #error Not Platform
#endif

#if defined(__L_WIN__)
    #if defined(__L_BUILD_DLL__) || defined(__L_CORE_API__)
        #define L_API extern "C" __declspec(dllexport)
    #elif defined(__L_USE_DLL__)
        #define L_API extern "C" __declspec(dllimport)
    #else
        #define L_API
    #endif
#else
    #ifdef __cplusplus
        #define L_API extern "C"
    #else
        #define L_API extern
    #endif
#endif

// false
#ifndef L_FALSE
    #define L_FALSE         0
#endif

// true
#ifndef L_TRUE
    #define L_TRUE          1
#endif

// void*: NULL
#ifndef NULL
    #define NULL            0
#endif

// int32: 成功
#ifndef L_SUCC
    #define L_SUCC          0
#endif

// int32: 失败
#ifndef L_FAIL
    #define L_FAIL          1
#endif

// int32: 错误
#ifndef L_ERR
    #define L_ERR           (-1)
#endif

#endif // __L_TYPE_H__
//end
