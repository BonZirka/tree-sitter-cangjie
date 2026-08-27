/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the Form class.
 */
package stdx.encoding.url

import std.collection.*

const MAX_URL_FORM_ITEMS: Int64 = 4096

/**
 * Form stores the key-value pair of the query part of the URL.
 *
 * @Since 0.18.6
 */
public class Form {
    private var data: HashMap<String, ArrayList<String>>

    private func itemCount(): Int64 {
        var count = 0
        for ((_, values) in data) {
            count += values.size
        }
        return count
    }

    private func ensureCanAddItem(addition: Int64): Unit {
        if (itemCount() + addition > MAX_URL_FORM_ITEMS) {
            throw IllegalStateException("Form item count exceeds ${MAX_URL_FORM_ITEMS}.")
        }
    }

    public init() {
        this.data = HashMap<String, ArrayList<String>>()
    }

    /**
     * Parse the URL-encoded query string and save the key-value pair.
     *
     * @param The query String that Separated by r'&' and r'='.
     *
     * @since 0.18.6
     *
     * @throws UrlSyntaxException if get an invalid URL escape
     */
    public init(queryComponent: String) {
        this()
        let arr = queryComponent.split("&", removeEmpty: true)
        for (query in arr) {
            let kv = query.split("=", 2)
            let key = decode(kv[0], isQuery: true)
            let value = if (kv.size == 1) {
                String.empty
            } else {
                decode(kv[1], isQuery: true)
            }
            ensureCanAddItem(1)
            if (data.contains(key)) {
                data[key].add(value)
            } else {
                data.add(key, ArrayList([value]))
            }
        }
    }

    /*
     * Call the function init(), used to clone a form.
     *
     * @since 0.18.6
     */
    private init(data: HashMap<String, ArrayList<String>>) {
        this.data = data
    }

    /**
     * Check whether the size of data is empty. If yes, true is returned. Otherwise, false is returned.
     *
     * @return bool if yes, true is returned. Otherwise, false is returned.
     *
     * @since 0.30.3
     */
    public func isEmpty(): Bool {
        return this.data.isEmpty()
    }

    /**
     * Obtains the value of the key. If the key corresponds to multiple values, the first value is returned.
     *
     * @param key The form query key.
     *
     * @return Option of the first value.
     *
     * @since 0.18.6
     */
    public func get(key: String): Option<String> {
        match (data.get(key)) {
            case Some(buffer) => buffer.get(0)
            case None => Option<String>.None
        }
    }

    /**
     * Obtains all values corresponding to the key in the ArrayList format.
     *
     * @param key The form query key.
     *
     * @return return all value the given key.
     *
     * @since 0.24.4
     */
    public func getAll(key: String): ArrayList<String> {
        match (data.get(key)) {
            case Some(buffer) => buffer.clone()
            case None => ArrayList<String>()
        }
    }

    /**
     * Save the key-value pair. If the key already exists, the value will be replaced.
     *
     * @param key The form query key.
     * @param value The form query value.
     *
     *
     * @since 0.18.6
     */
    public func set(key: String, value: String): Unit {
        if (!data.contains(key)) {
            ensureCanAddItem(1)
        }
        data.add(key, ArrayList([value]))
    }

    /**
     * Save the key-value pair. If the key already exists,
     * the values are not replaced, but are stored together in the Arraylist.
     *
     * @param key The form query key.
     * @param value The form query value.
     *
     * @since 0.18.6
     */
    public func add(key: String, value: String): Unit {
        ensureCanAddItem(1)
        if (data.contains(key)) {
            data[key].add(value)
        } else {
            data.add(key, ArrayList([value]))
        }
    }

    /**
     * Removes key-value pairs based on key.
     *
     * @param key The form query key.
     *
     * @since 0.18.6
     */
    public func remove(key: String): Unit {
        data.remove(key)
    }

    /**
     * Clone Form.
     *
     * @Return The clone Form instance
     * @since 0.18.6
     */
    public func clone(): Form {
        var cloneData = HashMap<String, ArrayList<String>>()
        for (i in data.keys()) {
            var buffer = data[i]
            cloneData.add(i, ArrayList(buffer))
        }
        return Form(cloneData)
    }
    /**
     * Converting a Form to an Encoded String
     *
     * @Return The encoded String
     * @since 0.18.6
     */
    public func toEncodeString(): String {
        if (!this.data.isEmpty()) {
            var strEnCode = StringBuilder()
            for ((k, v) in this.data) {
                for (vv in v) {
                    strEnCode.append(encode(k, UNRESERVED, isQuery: true))
                    strEnCode.append(r'=')
                    strEnCode.append(encode(vv, UNRESERVED, isQuery: true))
                    strEnCode.append(r'&')
                }
            }
            return strEnCode.toString()[..strEnCode.size - 1]
        }
        return ""
    }
}
