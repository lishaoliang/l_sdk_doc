#include <stdio.h>
#include "l_sdk.h"
#include "proto/l_nspp.h"
#include "proto/l_net.h"
#include "proto/l_media.h"
#include "proto/l_md_buf.h"
#include "l_sdk_picture.h"


#ifdef __L_WIN__
#include <windows.h>
static int wsa_startup()
{
    //windows上使用socket, 需要对WS2_32.DLL库进行初始化
    WSADATA wsa;
    if (0 != WSAStartup(MAKEWORD(2, 2), &wsa))
    {
        return 1;
    }

    return 0;
}
#else
static int wsa_startup() { return 0; }
#endif


// https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
#define T_LOGIN_STR     "{\"ip\":\"%s\",\"port\":%d,\"cmd\":\"login\",\"login\":{\"username\":\"%s\",\"passwd\":\"%s\"}}"

// https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
#define T_REQ_STREAM_STR   "{\"cmd\":\"open_stream\",\"open_stream\":{\"chnn\":%d,\"idx\":%d}}"


static int request_stream(id, chnn, idx)
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

static int save_jpeg(const char* p_path, const char* p_data, int data_len)
{
    FILE* pf = fopen(p_path, "wb");
    if (NULL != pf)
    {
        fwrite(p_data, 1, data_len, pf);
        fclose(pf);

        return 0;
    }

    return 1;
}

int t_stream_pic_main(int argc, char *argv[])
{
    // win socket环境
    wsa_startup();

    // sdk初始化
    int ret = l_sdk_init("");
    printf("(%s.%d)sdk init,ret=%d\n", __FILE__, __LINE__, ret);

    // 请求登录
    char req_login[128] = { 0 };
    snprintf(req_login, 124, T_LOGIN_STR, "192.168.1.247", 80, "admin", "123456");

    int id = 0;
    ret = l_sdk_login(&id, req_login);
    printf("(%s.%d)sdk login,ret=%d,id=%d\n", __FILE__, __LINE__, ret, id);

    if (0 == ret)
    {
        int stream_idx = 64;    // 64.图片流1; 65.图片流2

        // 登录成功, 后请求流
        request_stream(id, 0, stream_idx);

        int jpeg_index = 0;
        char jpeg_path[128] = { 0 };

        // 
        for (int i = 0; i < 10; i++)
        {
            l_md_buf_t* p_buf = NULL;
            if (0 == l_sdk_md_get(id, 0, stream_idx, 0, &p_buf))
            {
                snprintf(jpeg_path, 124, "./test_pic_%d.jpg", jpeg_index + 1);
                
                char* p_pic = p_buf->p_buf + p_buf->start;
                int pic_len = p_buf->end - p_buf->start;

#if 1
                int w = 0, h = 0;
                l_sdk_picture_size(p_pic, pic_len, 7, &w, &h);
                printf("(%s,%d)src jpeg size:[%d,%d]\n", __FILE__, __LINE__, w, h);

                l_sdk_picture_frame_t frame = { 0 };
                frame.w = 1920;
                frame.h = 1080;

                if ((frame.w != w || frame.h != h) && 
                    0 == l_sdk_picture_resize(p_pic, pic_len, 7, &frame, 6, 7))
                {
                    if (0 == save_jpeg(jpeg_path, frame.p_buffer, frame.data_length))
                    {
                        printf("(%s.%d)save jpeg ok,path=%s\n", __FILE__, __LINE__, jpeg_path);
                        jpeg_index += 1;
                    }

                    l_sdk_picture_free(&frame);
                }
                else
                {
                    //转换失败, 直接写原始图片
                    if (0 == save_jpeg(jpeg_path, p_pic, pic_len))
                    {
                        printf("(%s.%d)save jpeg ok,path=%s\n", __FILE__, __LINE__, jpeg_path);
                        jpeg_index += 1;
                    }
                }
#else
                if (0 == save_jpeg(jpeg_path, p_pic, pic_len))
                {
                    printf("(%s.%d)save jpeg ok,path=%s\n", __FILE__, __LINE__, jpeg_path);
                    jpeg_index += 1;
                }
#endif
                l_sdk_md_buf_sub(p_buf);
            }

            Sleep(1000);
        }
    }

    // 请求登出
    l_sdk_logout(id);

    // sdk退出
    l_sdk_quit();
    return 0;
}
