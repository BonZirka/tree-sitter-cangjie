// EXEC: %compiler %cmp_opt %f -o %output
// EXEC: %run %run_opt %output %run_args

main():Int64{
    let a:(public:Int64, private:Int64, protected:Int64, override:Int64, abstract:Int64, sealed:Int64, open:Int64, redef:Int64) = 
            (1, 1, 1, 1, 1, 1, 1, 1)
    return 0
}
// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.
