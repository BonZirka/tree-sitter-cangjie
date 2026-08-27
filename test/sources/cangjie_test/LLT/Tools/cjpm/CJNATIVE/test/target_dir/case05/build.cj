// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// build.cj

internal import std.process.*

// Case of pre/post codes for 'cjpm build'.
/* called before `cjpm build`
 * Success: return 0
 * Error: return any number except 0
 */
// func stagePreBuild(): Int64 {
//     // process before "cjpm build"
//     0
// }

/*
 * called after `cjpm build`
 */
// func stagePostBuild(): Int64 {
//     // process after "cjpm build"
//     0
// }

// Case of pre/post codes for 'cjpm clean'.
/* called before `cjpm clean`
 * Success: return 0
 * Error: return any number except 0
 */
// func stagePreClean(): Int64 {
//     // process before "cjpm clean"
//     0
// }

/*
 * called after `cjpm clean`
 */
// func stagePostClean(): Int64 {
//     // process after "cjpm clean"
//     0
// }

// For other options, define stagePreXXX and stagePostXXX in the same way.

/*
 * Error code:
 * 0: success.
 * other: cjpm will finish running command. Check BUILD_DIR/build-script/log for error outputs defind by user in functions.
 */
main(): Int64 {
    match (Process.current.arguments[0]) {
        // Add operation here with format: "pre-"/"post-" + optionName
        // case "pre-build" => stagePreBuild()
        // case "post-build" => stagePostBuild()
        // case "pre-clean" => stagePreClean()
        // case "post-clean" => stagePostClean()
        case _ => 0
    }
}
