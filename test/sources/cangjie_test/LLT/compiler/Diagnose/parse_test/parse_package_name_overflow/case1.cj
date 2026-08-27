// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// LEVEL: 0
// ERRCHECK: %compiler %noColor %n.cj

package a1.a2.a3.a4.a5.a6.a7.a8.a9.a10.a11.a12.a13.a14.a15.a16.a17.a18.a19.a20.a21.a22.a23.a24.a25.a26.a27.a28.a29.a30.a31.a32.a33.a34.a35.a36.a37.a38.a39.a40.a41.a42.a43.a44.a45.a46.a47.a48.a49.a50.a51.a52.aa

/* SCAN
error: length of package name 'a1.a2.a3.a4.a5.a6.a7.a8.a9.a10.a11.a12.a13.a14.a15.a16.a17.a18.a19.a20.a21.a22.a23.a24.a25.a26.a27.a28.a29.a30.a31.a32.a33.a34.a35.a36.a37.a38.a39.a40.a41.a42.a43.a44.a45.a46.a47.a48.a49.a50.a51.a52.aa' overflow
  ==> case1.cj:10:9:
   | 
10 | package a1.a2.a3.a4.a5.a6.a7.a8.a9.a10.a11.a12.a13.a14.a15.a16.a17.a18.a19.a20.a21.a22.a23.a24.a25.a26.a27.a28.a29.a30.a31.a32.a33.a34.a35.a36.a37.a38.a39.a40.a41.a42.a43.a44.a45.a46.a47.a48.a49.a50.a51.a52.aa
   |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ length overflow
   | 
   # note: the maximum length is 200, the real length is 201

1 error generated, 1 error printed.
*/
