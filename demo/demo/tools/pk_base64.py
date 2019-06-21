#!/usr/bin/python3
#-*-coding:utf-8-*-

useage = r"""将文件转换为Base64编码
  useage:
    pk_base64.py aaa.jpeg
"""

import sys
import base64
#print(len(sys.argv), str(sys.argv))


def main():
    if len(sys.argv) < 2:
        print(useage)
        exit(0)

    filename = sys.argv[1]
    out_filename = filename + ".b64.txt"
    #print('encode base64 file : "' + filename + '" => "' + out_filename + '"')

    try:
        with open(filename, 'rb') as r, open(out_filename, 'w') as w:
            data = r.read()
            s = base64.b64encode(data)
            w.write(str(s, 'utf-8'))
            print('encode base64 file : "' + filename + '" => "' + out_filename + '" ok!')

    except Exception as e:
        print('encode base64 file : "' + filename + '" => "' + out_filename + '" fail!')
        print(e)

if __name__ == "__main__":
    main()
