/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.posix.{creat, O_RDONLY}

import std.fs.{File, OpenMode, remove}

var j = 0

class A {}

extend A{
  public mut prop i: Int64 {
    get() {
      var pathName = "/mytmp/doc.txt"
      var fs: Int32 = creat(pathName,UInt32(O_RDONLY))
      fs = creat("!@#$%%^^&",UInt32(O_RDONLY))
      if (fs != -1) {
        print("This file already exists or created!")
      } else {
        return 1
      }
      return 0
    }
    set(v) {
      j = v
    }
  }
}

main(){
  if (A().i == 0){
    return 0
  }else{
    return 1
  }
}


