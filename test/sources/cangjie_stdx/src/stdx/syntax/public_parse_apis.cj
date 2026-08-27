/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.HashSet

/**
 * @brief Parses a source file located at the specified path and returns the parsing result.
 *
 * @param filePath The file path to the source file that needs to be parsed.
 * @return A ParsingResult object containing the parsed SourceFile or an error.
 *
 * @throws Exception if there is an issue reading the file.
 */
public func parseFile(filePath: String): ParsingResult<SourceFile> {
    let (file, diags) = Parser.parseFile(filePath)
    ParsingResult<SourceFile>(file, diags)
}

/**
 * @brief Parses a package located at the specified path and returns the parsing result.
 *
 * @param dirPath The directory path to the source files that needs to be parsed.
 * @return A ParsingResult object containing the parsed Package or an error.
 *
 * @throws Exception if there is an issue reading the file.
 */
public func parsePackage(dirPath: String): ParsingResult<Package> {
    let (pkg, diags) = Parser.parsePackage(dirPath)
    ParsingResult<Package>(pkg, diags)
}

func skipRedundancy(text: String) {
    return text.replace("\r\n", "").replace("\n", "").replace("\t", "").replace("\f", "").replace(" ", "").replace(";", "")
}

/**
 * @brief Parse the input text and return the parsing result along with diagnostic information.
 *
 * @param text The text that needs to be parsed.
 * @return A ParsingResult object containing the parsed node or an error.
 *
 * @throws Exception if there is an issue parsing the text.
 */
public func parseText(programText: String): ParsingResult<SyntaxTreeNode> {
    let (res, diags) = Parser.parseText(programText)
    // If the content of the parsed node is less than that of the input content, 
    // there are multiple input nodes.
    if (let Some(result) <- res && skipRedundancy(result.toString()).size < skipRedundancy(programText).size) {
        throw Exception("parseText function not support parse more than one node.")
    }
    ParsingResult<SyntaxTreeNode>(res, diags)
}

func checkPos(tokens: Tokens): Bool {
    var cur = Offset()
    var set = HashSet<UInt32>()
    var curFileId: UInt32 = tokens[0].pos.fileID
    for (token in tokens) {
        let pos = token.pos
        // For tokens from the same file, they must appear consecutively;
        // otherwise, their positions are considered invalid.
        if (pos.fileID != curFileId && set.contains(pos.fileID)) {
            return false
        }
        curFileId = pos.fileID
        set.add(curFileId)
        // Under the premise of considering the value of each Token, the 
        // positions of Tokens must be incremental; that is, the start 
        // position of a subsequent Token must be greater than the end position of the preceding Token.
        if (cur.line > pos.line || (cur.line == pos.line && cur.column > pos.column)) {
            return false
        }
        cur = Offset(pos.line, pos.column)
        cur.moveString(token.value)
    }
    return true
}

/**
 * @brief Parse the input tokens and return the parsing result along with diagnostic information.
 *
 * @param tokens The tokens that need to be parsed.
 * @return A ParsingResult object containing the parsed node or an error.
 *
 * @throws Exception if there is an issue parsing the tokens.
 */
public func parseTokens(tokens: Tokens, refreshPos!: Bool = true): ParsingResult<SyntaxTreeNode> {
    if (tokens.size == 0) {
        throw Exception("the input tokens is empty.")
    }
    if (!refreshPos && !checkPos(tokens)) { // check if the position of tokens is valid
        throw Exception("the position of the input tokens is invalid, you may open the refreshPos option.")
    }
    let (res, diags) = Parser.parseTokens(tokens, refreshPos)
    ParsingResult<SyntaxTreeNode>(res, diags)
}
