/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

@Annotation
public class CustomAnnotation1 {
    let name: String
    let version: Int64

    public const init(name: String, version!: Int64 = 0) {
        this.name = name
        this.version = version
    }
}

@Annotation
public class CustomAnnotation2 {
    let name: String
    let version: Int64

    public const init(name: String, version!: Int64 = 0) {
        this.name = name
        this.version = version
    }
}

@Annotation
public class CustomAnnotation3 {
    let name: String
    let version: Int64

    public const init(name: String, version!: Int64 = 0) {
        this.name = name
        this.version = version
    }
}

@CustomAnnotation1["Sample", version: 1]
@CustomAnnotation2["Sample", version: 1]
@CustomAnnotation3["Sample", version: 1]
interface Foo0 {}

@CustomAnnotation1["Sample", version: 1]
interface Foo1 {}

@CustomAnnotation2["Sample", version: 1]
@CustomAnnotation2["Sample", version: 1] // @CustomAnnotation2["Sample", version: 1]
interface Foo2 {}

@CustomAnnotation3["Sample", version: 1]
        // @CustomAnnotation3["Sample", version: 1]
interface Foo3 {}

main() {
}
