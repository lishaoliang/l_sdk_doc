#include <stdio.h>

extern int t_stream_main(int argc, char *argv[]);
extern int t_stream_dec_main(int argc, char *argv[]);


int main(int argc, char *argv[])
{
    int ret = 0;

    //ret = t_stream_main(argc, argv);
    ret = t_stream_dec_main(argc, argv);

    return ret;
}
