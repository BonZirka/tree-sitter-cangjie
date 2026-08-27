/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.fs.{File, OpenMode, remove}

enum A{
  AA
  static func foo(){
    var pathName = "/mytemp/doc.txt"
    var file: File = File(pathName, OpenMode.Append)
    if (file.canWrite()) {
      file.flush()
      file.close()
      print("This file already exists or created!")
      remove(pathName)
    } else {
      return 1
    }
    return 0
  }
}

main(){
  if (A.foo() == 0){
    return 0
  }else{
    return 1
  }
}


