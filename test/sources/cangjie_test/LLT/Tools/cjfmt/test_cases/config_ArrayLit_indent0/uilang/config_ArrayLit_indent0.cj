// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

let a=[]

let b=[1,2,3]

class albumState <: State {
  var pageNo: int64
  var imagePath:Array<String>

  init() {
    pageNo = 1
    imagePath = ["/Common/image/1.jpg",
      "/Common/image/2.jpg",
      "/Common/image/3.jpg",
      "/Common/image/4.jpg",
      "/Common/image/5.jpg",
      "/Common/image/6.jpg",
      "/Common/image/7.jpg",
      "/Common/image/8.jpg"
    ]
  }
}