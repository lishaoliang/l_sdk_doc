#include <jni.h>
#include <string>
#include <android/log.h>
#include <pthread.h>
#include <unistd.h>


#include "l_sdk.h"
#include "proto/l_nspp.h"
#include "proto/l_net.h"
#include "proto/l_media.h"
#include "proto/l_md_buf.h"


#define printf(fmt, ...)  ((void)__android_log_print(ANDROID_LOG_INFO, "l_sdk_test", fmt, ## __VA_ARGS__))


#define T_STREAM_DEC_ID         100

// https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
#define T_LOGIN_STR         "{\"ip\":\"%s\",\"port\":%d,\"cmd\":\"login\",\"login\":{\"username\":\"%s\",\"passwd\":\"%s\"}}"

// https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
#define T_REQ_STREAM_STR   "{\"cmd\":\"open_stream\",\"open_stream\":{\"chnn\":%d,\"idx\":%d}}"


static int cb_sdk_media(void* p_obj, int protocol, int id, int chnn, int idx, int md_id, l_md_buf_t* p_data)
{
    // p_obj 是调用 l_sdk_md_add_listener函数的第三个参数指针, 这里没有用到
    // protocol 为 proto/l_nspp.h 文件中定义主子协议类型
    // id 为登录ID
    // chnn 设备通道
    // idx 流序列号 参见 "proto/l_media.h" l_md_idx_e

    int proto_main = L_NET_PROTO_MAIN(protocol);
    int proto_sub = L_NET_PROTO_SUB(protocol);

    if (p_data->ver == L_MD_F_VER)
    {
        printf("fmt:%d,type:%d,len:%d\n", p_data->f_v1.fmt, p_data->f_v1.v_type, p_data->f_v1.len);

        if (L_FMT_H264 == p_data->f_v1.fmt)
        {
            if (L_MVT_I == p_data->f_v1.v_type)
            {
                // 关键帧
            }
            else
            {
                // 非关键帧
            }

            // H264
            int h264_len = p_data->f_v1.len;
            unsigned char* p_h264 = (unsigned char*)(p_data->p_buf + p_data->start);

            printf("h264 [%x,%x,%x,%x,%x]\n", p_h264[0], p_h264[1], p_h264[2], p_h264[3], p_h264[4]);
        }
        else if (L_FMT_H265 == p_data->f_v1.fmt)
        {

        }
        else if (L_FMT_AUDIO_B < p_data->f_v1.fmt && p_data->f_v1.fmt < L_FMT_AUDIO_E)
        {

        }
        else if (L_FMT_PIC_B < p_data->f_v1.fmt && p_data->f_v1.fmt < L_FMT_PIC_E)
        {

        }
    }

    return 0;
}

static int request_stream(int id, int chnn, int idx)
{
    // 请求码流
    char req_stream[128] = { 0 };
    snprintf(req_stream, 124, T_REQ_STREAM_STR, chnn, idx);

    char* p_res = NULL;
    int ret = l_sdk_request(id, req_stream, &p_res);
    printf("(%s.%d)ret=%d,res=%s\n", __FILE__, __LINE__, ret, (NULL != p_res) ? p_res : "error!");

    if (NULL != p_res)
    {
        l_sdk_free(p_res);
    }
    return 0;
}

static int test_discover()
{
    l_sdk_discover_open("");
    l_sdk_discover_run(L_TRUE);


    for (int i = 0; i < 6; i++)
    {
        char* p_devs = NULL;
        l_sdk_discover_get_devs(&p_devs);

        if (NULL != p_devs)
        {
            printf("get devs:%s\n", p_devs);

            l_sdk_free(p_devs);
        }
        else
        {
            printf("get devs:none\n");
        }

        //Sleep(500);
        usleep(500 * 1000);
    }


    l_sdk_discover_run(L_FALSE);
    l_sdk_discover_close();
    return 0;
}

int t_stream_dec_main(int argc, char *argv[])
{
    // win socket环境
    // wsa_startup();
    // 注意开启网络权限: <uses-permission android:name="android.permission.INTERNET"></uses-permission>
    printf("***************************************************\n");

    // sdk初始化
    int ret = l_sdk_init("");
    printf("(%s.%d)sdk init,ret=%d\n", __FILE__, __LINE__, ret);

    usleep(500 * 1000);

    // 测试广播搜索
    test_discover();

    // 添加媒体数据监听者
    l_sdk_md_add_listener("my listener 1", cb_sdk_media, NULL);

    // 打开一个解码器
    ret = l_sdk_dec_open(T_STREAM_DEC_ID, "");
    printf("(%s.%d)sdk dec open,ret=%d\n", __FILE__, __LINE__, ret);

    // 请求登录
    char req_login[128] = { 0 };
    snprintf(req_login, 124, T_LOGIN_STR, "192.168.3.240", 80, "admin", "123456");
    printf("req login:%s", req_login);

    int id = 0;
    ret = l_sdk_login(&id, req_login);
    printf("(%s.%d)sdk login,ret=%d,id=%d\n", __FILE__, __LINE__, ret, id);

    if (0 == ret)
    {
        // 登录成功, 后请求流
        request_stream(id, 0, 0);

        // 绑定解码器
        l_sdk_dec_bind(T_STREAM_DEC_ID, id, 0, 0, 0);

        //
        for (int i = 0; i < 200; i++)
        {
            l_md_data_t* p_md_data = NULL;
            if (0 == l_sdk_dec_get_md_data(T_STREAM_DEC_ID, &p_md_data))
            {
                assert(NULL != p_md_data);
                if (NULL != p_md_data)
                {
                    // L_MDDT_YUV420P_SEPARATE
                    printf("type:%d, wh:[%d.%d], ptr yuv:[0x%p,0x%p,0x%p]\n", p_md_data->type, p_md_data->w, p_md_data->h,
                           p_md_data->p_y, p_md_data->p_u, p_md_data->p_v);

                    l_sdk_dec_free_md_data(p_md_data);
                }
            }

            //Sleep(15);  // 30帧图像, 最少保持 1000 / 30 / 2
            usleep(15 * 1000);
        }
    }

    // 请求登出
    l_sdk_logout(id);

    // 关闭解码器
    l_sdk_dec_close(T_STREAM_DEC_ID);

    // sdk退出
    l_sdk_quit();
    return 0;
}

extern "C" JNIEXPORT jstring JNICALL
Java_com_afscope_ndkandroid_MainActivity_Test(
        JNIEnv* env,
        jobject /* this */) {

    t_stream_dec_main(0, NULL);

    __android_log_print(ANDROID_LOG_INFO, "native", "streamRequest1=%d", 0);
    return 0;
}
