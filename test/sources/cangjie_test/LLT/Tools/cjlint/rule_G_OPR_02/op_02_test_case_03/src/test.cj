// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

enum E {
    Y | X

}

extend E{
    operator func ()() {
    }
    
    operator func ()(a:Int64) {
        print(a)
    }
}

main(){
    return 0
}