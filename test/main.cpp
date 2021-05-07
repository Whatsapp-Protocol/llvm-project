#include <clang_export.h>
#include <lli_export.h>

#include <corecrt_io.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <thread>
#include <windows.h>

char *get_output_from_fd(int fd) {
  //动态申请空间
  char *str = (char *)malloc((4097) * sizeof(char));
  // read函数返回从fd中读取到字符的长度
  //读取的内容存进str,4096表示此次读取4096个字节，如果只读到10个则length为10
  int length = read(fd, str, 4096);
  if (length == -1) {
    free(str);
    return NULL;
  } else {
    str[length] = '\0';
    return str;
  }
}
int main() {
  std::thread a([] {
    char buffer[1];
    while (true) {
      DWORD nread = 0;
      BOOL success = fread(buffer, 1, 1, stdout);
      nread = 1;
    }
  });
  a.detach();
  // llvm-link
  // clang -emit-llvm -o test.bc -c test.c
  {
    char *args[8];
    args[0] = new char[100];
    strcpy(args[0], "test");

    args[1] = new char[100];
    strcpy(args[1], "-emit-llvm");

    args[2] = new char[100];
    strcpy(args[2], "-o");

    args[3] = new char[100];
    strcpy(args[3], "f:\\llvm\\test123.bc");

    args[4] = new char[100];
    strcpy(args[4], "-c");

    args[5] = new char[100];
    strcpy(args[5], "F:\\llvm\\test.cpp");

    args[6] = new char[100];
    strcpy(args[6], ">>");

    args[7] = new char[100];
    strcpy(args[7], "F:\\llvm\\test.txt");

    FILE *f_error = fopen("F:\\llvm\\error.txt", "w+");
    abc_set_error_fd(fileno(f_error));

    FILE *f_out = fopen("F:\\llvm\\output.txt", "w+");
    abc_set_out_fd(fileno(f_out));

    // abc_execute(6, (const char **)args);
    fclose(f_error);
  }

  {
    char *args[2];
    args[0] = new char[100];
    strcpy(args[0], "test");

    args[1] = new char[100];
    strcpy(args[1], "f:\\llvm\\test123.bc");

    cde_execute(2, (const char **)args);
  }

  getchar();

  return 0;
}
