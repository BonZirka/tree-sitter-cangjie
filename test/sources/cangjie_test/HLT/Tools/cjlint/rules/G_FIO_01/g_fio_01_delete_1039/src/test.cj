/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.fs.{File, OpenMode, remove}

func foo(){
  var pathName = "/tempmytempggmggp/doc.txt"
  var a:Unit = match(pathName) {
    case "x" => ()
    case _ => var b = File(pathName, OpenMode.Append)
  }
  if (true){
    print("This file already exists or created!")
    remove(pathName)
  }else{
    remove(pathName)
  }
  return 0
}

main(){
  foo()
}


