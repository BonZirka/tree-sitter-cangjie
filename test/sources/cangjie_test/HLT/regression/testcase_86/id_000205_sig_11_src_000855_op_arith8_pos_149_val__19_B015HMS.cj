/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 * 
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 
// LEVEL: 0
// ERRCHECK: %compiler %cmp_opt %f -o %output


public class ArrayList<E> {
    public var myData2: Array<Option<E>> = [Optio[<E>.None];
    var c = match myData2[0] {
        case Some(x) => "1";
        case _ =>"3";
    }
}

main() {
  var a = ArrayList<Float32>();
  var b = ArrayLi%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x
// ASSERT: scan parse_expected_expression
// ASSERT: scan parse_chained_none_associative
// ASSERT: scan parse_expected_right_delimiter
// ASSERT: scan parse_selector_or_match_expression_body


