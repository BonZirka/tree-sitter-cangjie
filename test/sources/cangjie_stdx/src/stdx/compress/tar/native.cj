/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.fs.{Path, FileInfo}

private class AutoCString <: Resource {
    let str: CString
    private var _isClosed = false

    init(s: String) {
        str = unsafe { LibC.mallocCString(s) }
    }

    init(path: Path) {
        this(path.toString())
    }

    public func close(): Unit {
        if (!_isClosed) {
            unsafe { LibC.free(str) }
        }
    }

    public func isClosed(): Bool {
        return _isClosed
    }
}

private func callNativeGetFunc(nativeFunc: CFunc<(CString) -> Int32>, funcName: String, path: Path): Int32 {
    try (s = AutoCString(path)) {
        let result = unsafe { nativeFunc(s.str) }
        if (result == -1) {
            throw TarException("Failed to call native function ${funcName} for path: ${path}.")
        }
        return result
    }
    throw TarException("Unreachable code.")
}

private func callNativeGetFunc(nativeFunc: CFunc<(CString) -> CString>, funcName: String, path: Path): String {
    try (s = AutoCString(path)) {
        let result = unsafe { nativeFunc(s.str) }
        if (result.isNull()) {
            throw TarException("Failed to call native function ${funcName} for path: ${path}.")
        }
        return result.toString()
    }
    throw TarException("Unreachable code.")
}

private func callNativeSetFunc(nativeFunc: CFunc<(CString, Int32) -> Int32>, funcName: String, path: Path, value: Int32, ignoreFailure!: Bool = false): Unit {
    try (s = AutoCString(path)) {
        let result = unsafe { nativeFunc(s.str, value) }
        if (result == -1 && !ignoreFailure) {
            throw TarException("Failed to call native function ${funcName} for path: ${path}, value: ${value}.")
        }
    }
}

private func callNativeSetFunc(nativeFunc: CFunc<(CString, Int64) -> Int32>, funcName: String, path: Path, value: Int64): Unit {
    try (s = AutoCString(path)) {
        let result = unsafe { nativeFunc(s.str, value) }
        if (result == -1) {
            throw TarException("Failed to call native function ${funcName} for path: ${path}, value: ${value}.")
        }
    }
}

private func callNativeSetFunc(nativeFunc: CFunc<(CString, CString) -> Int32>, funcName: String, path: Path, value: String, ignoreFailure!: Bool = false): Unit {
    try (s = AutoCString(path), v = AutoCString(value)) {
        let result = unsafe { nativeFunc(s.str, v.str) }
        if (result == -1 && !ignoreFailure) {
            throw TarException("Failed to call native function ${funcName} for path: ${path}, value: ${value}.")
        }
    }
}

@When[os != "Windows"]
foreign func CJ_TAR_GetMode(path: CString): Int32
@When[os != "Windows"]
foreign func CJ_TAR_GetUid(path: CString): Int32
@When[os != "Windows"]
foreign func CJ_TAR_GetGid(path: CString): Int32
@When[os != "Windows"]
foreign func CJ_TAR_GetUserName(path: CString): CString
@When[os != "Windows"]
foreign func CJ_TAR_GetGroupName(path: CString): CString
@When[os != "Windows"]
foreign func CJ_TAR_GetDeviceMajor(path: CString): Int32
@When[os != "Windows"]
foreign func CJ_TAR_GetDeviceMinor(path: CString): Int32

@When[os != "Windows"]
foreign func CJ_TAR_SetMode(path: CString, mode: Int32): Int32
@When[os != "Windows"]
foreign func CJ_TAR_SetUid(path: CString, uid: Int32): Int32
@When[os != "Windows"]
foreign func CJ_TAR_SetGid(path: CString, gid: Int32): Int32
@When[os != "Windows"]
foreign func CJ_TAR_SetUserName(path: CString, userName: CString): Int32
@When[os != "Windows"]
foreign func CJ_TAR_SetGroupName(path: CString, groupName: CString): Int32

foreign func CJ_TAR_SetModificationTime(path: CString, timestamp: Int64): Int32
foreign func CJ_TAR_SetAccessTime(path: CString, timestamp: Int64): Int32

@When[os == "Windows"]
foreign func CJ_TAR_SetChangeTime(path: CString, timestamp: Int64): Int32

class Native {
    private init() { } // static class

    @When[os != "Windows"]
    static func getMode(path: Path): Int32 { callNativeGetFunc(CJ_TAR_GetMode, "CJ_TAR_GetMode", path) }
    @When[os != "Windows"]
    static func getUid(path: Path): Int32 { callNativeGetFunc(CJ_TAR_GetUid, "CJ_TAR_GetUid", path) }
    @When[os != "Windows"]
    static func getGid(path: Path): Int32 { callNativeGetFunc(CJ_TAR_GetGid, "CJ_TAR_GetGid", path) }

    @When[os != "Windows"]
    static func getUserName(path: Path): String { callNativeGetFunc(CJ_TAR_GetUserName, "CJ_TAR_GetUserName", path) }
    @When[os != "Windows"]
    static func getGroupName(path: Path): String { callNativeGetFunc(CJ_TAR_GetGroupName, "CJ_TAR_GetGroupName", path) }
    @When[os != "Windows"]
    static func getDeviceMajor(path: Path): Int32 { callNativeGetFunc(CJ_TAR_GetDeviceMajor, "CJ_TAR_GetDeviceMajor", path) }
    @When[os != "Windows"]
    static func getDeviceMinor(path: Path): Int32 { callNativeGetFunc(CJ_TAR_GetDeviceMinor, "CJ_TAR_GetDeviceMinor", path) }

    @When[os == "Windows"]
    static func getMode(path: Path): Int32 {
        // This function behavior is same as windows platform tar
        let info = FileInfo(path)
        if (info.isDirectory()) {
            return 0o777
        }
        let canRead = !info.isReadOnly()
        let canExecute = info.canExecute()
        match ((canRead, canExecute)) {
            case (true, true) => 0o777
            case (true, false) => 0o666
            case (false, true) => 0o555
            case (false, false) => 0o444
        }
    }

    // cjlint-ignore -start !G.FUN.02
    @When[os == "Windows"]
    static func getUid(path: Path): Int32 { 0 }
    @When[os == "Windows"]
    static func getGid(path: Path): Int32 { 0 }

    @When[os == "Windows"]
    static func getUserName(path: Path): String { "" }
    @When[os == "Windows"]
    static func getGroupName(path: Path): String { "" }
    @When[os == "Windows"]
    static func getDeviceMajor(path: Path): Int32 { 0 }
    @When[os == "Windows"]
    static func getDeviceMinor(path: Path): Int32 { 0 }

    @When[os != "Windows"]
    static func setMode(path: Path, mode: Int32): Unit { callNativeSetFunc(CJ_TAR_SetMode, "CJ_TAR_SetMode", path, mode) }
    @When[os != "Windows"]
    static func setUid(path: Path, uid: Int32): Unit { 
        // Ignore failure when setting UID/GID as normal users cannot change ownership
        // This matches GNU tar behavior where non-root users extract files as themselves
        callNativeSetFunc(CJ_TAR_SetUid, "CJ_TAR_SetUid", path, uid, ignoreFailure: true) 
    }
    @When[os != "Windows"]
    static func setGid(path: Path, gid: Int32): Unit { 
        // Ignore failure when setting UID/GID as normal users cannot change ownership
        // This matches GNU tar behavior where non-root users extract files as themselves
        callNativeSetFunc(CJ_TAR_SetGid, "CJ_TAR_SetGid", path, gid, ignoreFailure: true) 
    }

    @When[os != "Windows"]
    static func setUserName(path: Path, userName: String): Unit { 
        // Ignore failure when setting user/group name as the user/group may not exist on target system
        // This matches GNU tar behavior which falls back to UID/GID when name lookup fails
        callNativeSetFunc(CJ_TAR_SetUserName, "CJ_TAR_SetUserName", path, userName, ignoreFailure: true) 
    }
    @When[os != "Windows"]
    static func setGroupName(path: Path, groupName: String): Unit { 
        // Ignore failure when setting user/group name as the user/group may not exist on target system
        // This matches GNU tar behavior which falls back to UID/GID when name lookup fails
        callNativeSetFunc(CJ_TAR_SetGroupName, "CJ_TAR_SetGroupName", path, groupName, ignoreFailure: true) 
    }

    @When[os == "Windows"]
    static func setMode(path: Path, mode: Int32): Unit {
        // Only support writable mode on windows
        const CAN_WRITE_MASK: Int32 = 0o200
        FileInfo(path).setWritable((mode & CAN_WRITE_MASK) != 0)
    }
    @When[os == "Windows"]
    static func setUid(path: Path, uid: Int32): Unit { }
    @When[os == "Windows"]
    static func setGid(path: Path, gid: Int32): Unit { }

    @When[os == "Windows"]
    static func setUserName(path: Path, userName: String): Unit { }
    @When[os == "Windows"]
    static func setGroupName(path: Path, groupName: String): Unit { }
    // cjlint-ignore -end

    static func setModificationTime(path: Path, timestamp: Int64): Unit {
        callNativeSetFunc(CJ_TAR_SetModificationTime, "CJ_TAR_SetModificationTime", path, timestamp)
    }
    static func setAccessTime(path: Path, timestamp: Int64): Unit {
        callNativeSetFunc(CJ_TAR_SetAccessTime, "CJ_TAR_SetAccessTime", path, timestamp)
    }

    @When[os != "Windows"]
    static func setChangeTime(path: Path, timestamp: Int64): Unit { // cjlint-ignore !G.FUN.02
        // Can not modify change time on unix
    }

    @When[os == "Windows"]
    static func setChangeTime(path: Path, timestamp: Int64): Unit {
        callNativeSetFunc(CJ_TAR_SetChangeTime, "CJ_TAR_SetChangeTime", path, timestamp)
    }

    static func setFileAttributes(path: Path, entry: TarEntry): Unit {
        Native.setMode(path, entry.mode)
        Native.setUid(path, entry.uid)
        Native.setGid(path, entry.gid)
        Native.setModificationTime(path, entry.modificationTime.toUnixTimeStamp().toSeconds())
        if (let Some(posix) <- (entry as PosixTarEntry)) {
            Native.setUserName(path, posix.userName)
            Native.setGroupName(path, posix.groupName)
        }
        if (let Some(gnu) <- (entry as GnuTarEntry)) {
            Native.setAccessTime(path, gnu.accessTime.toUnixTimeStamp().toSeconds())
            Native.setChangeTime(path, gnu.changeTime.toUnixTimeStamp().toSeconds())
        }
    }
}
