/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// EXEC: %compiler %cmp_opt -Woff=all %n.cj -o %output %cmp_utest_opt 2>&1
// EXEC-PIPE-1: %run %run_opt %output %run_utest_opt %run_args 2>&1 | compare %f

@Test
public class Test_AssertEqual_String_UnEqual {
    @TestCase
    func test_assert_long_string() {
        let str1 = ###"class Page {
    var pe: ?PartialEvaluator
    var pageNumber: Int64
    var pageDict: ?Dict
    var xref: XRef
    var ref: Ref

    var displayReadyPromise: ?PDFPromise

    init(xref: XRef, pageNumber: Int64, pageDict: Dict, ref: Ref) {
        this.pageNumber = pageNumber
        this.pageDict = pageDict
        this.xref = xref
        this.ref = ref

        this.displayReadyPromise = Option<PDFPromise>.None
    }

    func getPageProp(key: String) : ?Any {
        return this.pageDict.getOrThrow().get(key)
    }

    func inheritPageProp(key: String) : ?Any {
        var dict: ?Dict = this.pageDict
        var obj: ?Any = dict.getOrThrow().get(key)
        while ( obj.isNone()) {
            dict = dict.getOrThrow().get("Parent").getOrThrow() as Dict
            if ( dict.isNone()) {
                break  //???
            }
            obj = dict.getOrThrow().get(key)
        }
        return obj
    }

    prop content: ?Any {
        get() {
            return this.getPageProp("Contents")
        }
    }

    prop resources: ?Any {
        get() {
            return this.getPageProp("Resources")
        }
    }

    prop mediaBox: ArrayList<Float32> {
        get() {
            var obj: ?Any = this.inheritPageProp("MediaBox")
            if ( !isArray(obj.getOrThrow() as Any) || (obj.getOrThrow() as ArrayList<Float32>).getOrThrow().size != 4) {
                obj = [0.0, 0.0, 612.0, 792.0]
            }
            return (obj.getOrThrow() as ArrayList<Float32>).getOrThrow()            
        }
    }

    prop view: ArrayList<Float32> {
        get() {
            let mediaBox: ArrayList<Float32> = this.mediaBox
            var cropBox: ?Any = this.inheritPageProp("CropBox")
            if ( !isArray(cropBox.getOrThrow() as Any) || (cropBox.getOrThrow() as ArrayList<Float32>).getOrThrow().size != 4) {
                return mediaBox
            }
            cropBox = Util.intersect((cropBox.getOrThrow() as ArrayList<Float32>).getOrThrow(), mediaBox )
            if ( cropBox.isNone()) {
                return mediaBox
            }
            return (cropBox.getOrThrow() as ArrayList<Float32>).getOrThrow()            
        }
    }

    prop annotations: ?Any {
        get() {
            return this.inheritPageProp("Annots")
        }
    }

    prop rotate: Float32 {
        get() {
            var rotate: Int64 = this.inheritPageProp("Rotate").getOrThrow() as Int64 ?? 0
            if (rotate % 90 != 0) {
                rotate = 0
            } else if ( rotate >= 360) {
                rotate = rotate % 360
            } else if ( rotate < 0) {
                rotate = ((rotate % 360) + 360) % 360
            }
            return Float32(rotate)            
        }
    }

    func getOperatorList(handler: MessageHandler, dependency: ArrayList<String>) : OperatorList {
        let xref: XRef = this.xref
        var content: ?Any = this.content
        let resources: ?Any = this.resources
        //println("debug getOperatorList xref entries length resources map,${xref.entries.size,(resources as Dict).getOrThrow().map}")
        if ( isArray(content)) {
            var streams: ArrayList<Stream> = ArrayList<Stream>()
            let n: Int64 = (content.getOrThrow() as ArrayList<Any>).getOrThrow().size
            for (i in 0..n) {
                streams.push(xref.fetchIfRef(((content.getOrThrow() as ArrayList<Any>).getOrThrow()[i]) as Stream).getOrThrow())
            }
            content = StreamsSequenceStream(streams)
        } else if ( isStream(content)) {
            (content.getOrThrow() as Stream).getOrThrow().reset()
        } else if ( content.isNone()) {
            content = Stream(Array<UInt8>())
        }
        this.pe = PartialEvaluator(xref,  handler,  "p${this.pageNumber}_")
        let pe: PartialEvaluator = this.pe.getOrThrow()
        return pe.getOperatorList((content.getOrThrow() as Stream).getOrThrow(), (resources.getOrThrow() as Dict).getOrThrow(), dependency)
    }

    func getLinks() : ArrayList<PageAnnotationItem> {
        var links: ArrayList<PageAnnotationItem> = ArrayList<PageAnnotationItem>()
        let annotations: ArrayList<PageAnnotationItem> = getAnnotations()
        for ( annotation in annotations) {
            if ( annotation._type != "Link") {
                continue
            }
            links.push(annotation)
        }
        return links
    }

    func getAnnotations() : ArrayList<PageAnnotationItem> {
        let xref: XRef = this.xref
        func getInheritableProperty(annotation: ?Dict, name: String) : ?Any {
            var item: ?Dict = annotation
            while ( item.isSome() && !(item.getOrThrow().has(name))) {
                item = item.getOrThrow().get("Parent").getOrThrow() as Dict
            }
            if ( item.isNone()) {
                return Option<Any>.None
            }
            return item.getOrThrow().get(name)
        }
        func isValidUrl(url: ?String) : Bool {
            if ( url.isNone()) {
                return false
            }
            let colon: ?Int64 = url.getOrThrow().indexOf(":")
            if ( colon.isNone()) {
                return false
            }
            let protocolStr: String = url.getOrThrow()[0..colon]
            match(protocolStr) {
                case "http" | "https" | "ftp" | "mailto" =>
                    return true
                case _ =>
                    return false
            }
        }

        let annotations: ArrayList<Ref> = this.annotations.getOrThrow() as ArrayList<Ref> ?? ArrayList<Ref>()
        var items: ArrayList<PageAnnotationItem> = ArrayList<PageAnnotationItem>()
        for (i in 0..annotations.size) {
            let annotationRef: Ref = annotations[i];
            let annotation: ?Dict = xref.fetch(annotationRef).getOrThrow() as Dict
            if ( !isDict(annotation)) {
                continue
            }
            let subtype: ?Name = annotation.getOrThrow().get("Subtype").getOrThrow() as Name
            if ( !isName(subtype)) {
                continue
            }
            let rect: ?Any = annotation.getOrThrow().get("Rect")

            let item: PageAnnotationItem = PageAnnotationItem()
            item._type = subtype.getOrThrow().name
            item.rect = rect
            match ( subtype.getOrThrow().name) {
            case "Link" =>
                let a: ?Dict = annotation.getOrThrow().get("A").getOrThrow() as Dict
                if ( a.isSome()) {
                    match ( (a.getOrThrow().get("S").getOrThrow() as Name).getOrThrow().name) {
                    case "URI" =>
                        var url: ?String = a.getOrThrow().get("URI").getOrThrow() as String
                        if ( url.isSome() && !isValidUrl(url)) {
                            url = ""
                        }
                        item.url = url
                    case "GoTo" =>
                        item.dest = a.getOrThrow().get("D")
                    case _ =>
                        TODO("other link types")
                        // break  //???
                    }
                } else if (annotation.getOrThrow().has("Dest")) {
                    let dest: ?Any = annotation.getOrThrow().get("Dest")
                    if (isName(dest)) {
                        item.dest = (dest.getOrThrow() as Name).getOrThrow().name
                    } else {
                        item.dest = dest
                    }
                }
            case "Widget" =>
                let fieldType: ?Name = getInheritableProperty(annotation, "FT").getOrThrow() as Name
                if ( !isName(fieldType)) {
                    break  //???
                }
                item.fieldType = fieldType.getOrThrow().name
                var fieldName: ArrayList<String> = ArrayList<String>()
                var namedItem: ?Dict = annotation
                var ref: Ref = annotationRef
                while ( namedItem.isSome()) {
                    let parent: ?Dict = namedItem.getOrThrow().get("Parent").getOrThrow() as Dict
                    let parentRef: Ref = (namedItem.getOrThrow().getRaw("Parent").getOrThrow() as Ref).getOrThrow()
                    let name: ?String = namedItem.getOrThrow().get("T").getOrThrow() as String
                    if ( name.isSome()) {
                        fieldName.insert(0, stringToPDFString(name.getOrThrow()))
                    } else {
                        let kids: ArrayList<Ref> = (parent.getOrThrow().get("Kids").getOrThrow() as ArrayList<Ref>).getOrThrow()
                        var j: Int64 = 0
                        let jj: Int64 = kids.size
                        while ( j < jj) {
                            let kidRef: Ref = kids[j]
                            if ( kidRef.num == ref.num && kidRef.gen == ref.gen) {
                                break
                            }
                            j += 1
                        }
                        fieldName.insert(0, "`${j}")
                    }
                    namedItem = parent
                    ref = parentRef
                }
                item.fullName = String.join(fieldName, delimiter: ".")
                let alternativeText: String = stringToPDFString(annotation.getOrThrow().get("TU").getOrThrow() as String ?? "")
                item.alternativeText = alternativeText
                let da: String = getInheritableProperty(annotation, "DA").getOrThrow() as String ?? ""
                let regex: Regex = Regex("([\\d.]+) Tf")
                let _match: Matcher = regex.matcher("da").find()
                if ( _match.isSome()) {
                    item.fontSize = floatValue(da[_match.getOrThrow().matchString(0)])
                }
                item.textAlignment = getInheritableProperty(annotation, "Q")
                item.flags = getInheritableProperty(annotation.getOrThrow(), "Ff").getOrThrow() as Int64 ?? 0
            case "Text" =>
                item.content = stringToPDFString(annotation.getOrThrow().get("Contents").getOrThrow() as String ?? "")
                item.title = stringToPDFString(annotation.getOrThrow().get("T").getOrThrow() as String ?? "")
                if (!annotation.getOrThrow().has("Name")) {
                    item.name = "Note"
                } else {
                    item.name = (annotation.getOrThrow().get("Name").getOrThrow() as Name).getOrThrow().name ?? ""
                }
            case _ =>
                TODO("unimplemented annotation type: " + subtype.getOrThrow().name)
                // break //???
            }
            items.push(item)
        }
        return items
    }
}"###
        let str2 = ###"class Page {
    var pe: PartialEvaluator?
    var pageNumber: Int
    var pageDict: Dict?
    var xref: XRef
    var ref: Ref

    var displayReadyPromise: PDFPromise?

    init(_ xref: XRef, _ pageNumber: Int, _ pageDict: Dict, _ ref: Ref) {
        self.pageNumber = pageNumber
        self.pageDict = pageDict
        self.xref = xref
        self.ref = ref

        self.displayReadyPromise = nil
    }

    func getPageProp(_ key: String) -> Any? {
        return self.pageDict!.get(key)
    }

    func inheritPageProp(_ key: String) -> Any? {
        var dict: Dict? = self.pageDict
        var obj: Any? = dict!.get(key)
        while obj == nil {
            dict = dict!.get("Parent") as? Dict
            if dict == nil {
                break
            }
            obj = dict!.get(key)
        }
        return obj
    }

    var content: Any? {
        return self.getPageProp("Contents")
    }

    var resources: Any? {
        return self.getPageProp("Resources")
    }

    var mediaBox: [Float] {
        var obj: Any? = self.inheritPageProp("MediaBox")
        if !isArray(obj as Any) || (obj as? [Float])?.count != 4 {
            obj = [0.0, 0.0, 612.0, 792.0].map { Float($0) }
        }
        return obj as! [Float]
    }

    var view: [Float] {
        let mediaBox: [Float] = self.mediaBox
        var cropBox: Any? = self.inheritPageProp("CropBox")
        if !isArray(cropBox as Any) || (cropBox as? [Float])?.count != 4 {
            return mediaBox
        }
        cropBox = Util.intersect(cropBox as! [Float], mediaBox )
        if cropBox == nil {
            return mediaBox
        }
        return cropBox as! [Float]
    }

    var annotations: Any? {
        return self.inheritPageProp("Annots")
    }

    var rotate: Float {
        var rotate: Int = self.inheritPageProp("Rotate") as? Int ?? 0
        if rotate % 90 != 0 {
            rotate = 0
        } else if rotate >= 360 {
            rotate = rotate % 360
        } else if rotate < 0 {
            rotate = ((rotate % 360) + 360) % 360
        }
        return Float(rotate)
    }

    func getOperatorList(_ handler: MessageHandler, _ dependency: inout [String]) -> OperatorList {
        let xref: XRef = self.xref
        var content: Any? = self.content
        let resources: Any? = self.resources
        //pprint("debug getOperatorList xref entries length resources map",xref.entries.count,(resources as! Dict).map)
        if isArray(content) {
            var streams: [Stream] = Array<Stream>()
            let n: Int = (content as! [Any]).count
            for i in 0..<n {
                streams.push(xref.fetchIfRef((content as! [Any])[i]) as! Stream)
            }
            content = StreamsSequenceStream(streams)
        } else if isStream(content) {
            (content as! Stream).reset()
        } else if content == nil {
            content = Stream([UInt8()])
        }
        self.pe = PartialEvaluator( xref,  handler,  "p\(self.pageNumber)_")
        let pe: PartialEvaluator = self.pe!
        return pe.getOperatorList(content as! Stream, resources as! Dict, &dependency)
    }

    func getLinks() -> [PageAnnotationItem] {
        var links: [PageAnnotationItem] = Array<PageAnnotationItem>()
        let annotations: [PageAnnotationItem] = getAnnotations()
        for annotation in annotations {
            if annotation.type != "Link" {
                continue
            }
            links.push(annotation)
        }
        return links
    }

    func getAnnotations() -> [PageAnnotationItem] {
        let xref: XRef = self.xref
        func getInheritableProperty(_ annotation: Dict?, _ name: String) -> Any? {
            var item: Dict? = annotation
            while item != nil && !(item!.has(name)) {
                item = item!.get("Parent") as? Dict
            }
            if item == nil {
                return nil
            }
            return item!.get(name)
        }
        func isValidUrl(_ url: String?) -> Bool {
            if url == nil {
                return false
            }
            let colon: String.Index? = url!.firstIndex(of: ":")
            if colon == nil {
                return false
            }
            let protocolStr: String = String(url!.prefix(upTo: colon!))
            switch protocolStr {
            case "http",
                 "https",
                 "ftp",
                 "mailto":
                return true
            default:
                return false
            }
        }

        let annotations: [Ref] = self.annotations as? [Ref] ?? Array<Ref>()
        var items: [PageAnnotationItem] = Array<PageAnnotationItem>()
        for i in 0..<annotations.count {
            let annotationRef: Ref = annotations[i];
            let annotation: Dict? = xref.fetch(annotationRef) as? Dict
            if !isDict(annotation) {
                continue
            }
            let subtype: Name? = annotation!.get("Subtype") as? Name
            if !isName(subtype) {
                continue
            }
            let rect: Any? = annotation!.get("Rect")

            let item: PageAnnotationItem = PageAnnotationItem()
            item.type = subtype!.name
            item.rect = rect
            switch subtype!.name {
            case "Link":
                let a: Dict? = annotation!.get("A") as? Dict
                if a != nil {
                    switch (a!.get("S") as! Name).name {
                    case "URI":
                        var url: String? = a!.get("URI") as? String
                        if url != nil && !isValidUrl(url) {
                            url = ""
                        }
                        item.url = url
                    case "GoTo":
                        item.dest = a!.get("D")
                    default:
                        TODO("other link types")
                        break
                    }
                } else if annotation!.has("Dest") {
                    let dest: Any? = annotation!.get("Dest")
                    item.dest = isName(dest) ? (dest as! Name).name : dest
                }
            case "Widget":
                let fieldType: Name? = getInheritableProperty(annotation, "FT") as? Name
                if !isName(fieldType) {
                    break
                }
                item.fieldType = fieldType!.name
                var fieldName: [String] = Array<String>()
                var namedItem: Dict? = annotation
                var ref: Ref = annotationRef
                while namedItem != nil {
                    let parent: Dict? = namedItem!.get("Parent") as? Dict
                    let parentRef: Ref = namedItem!.getRaw("Parent") as! Ref
                    let name: String? = namedItem!.get("T") as? String
                    if name != nil {
                        fieldName.insert(stringToPDFString(name!), at: 0)
                    } else {
                        let kids: [Ref] = parent!.get("Kids") as! [Ref]
                        var j: Int = 0
                        let jj: Int = kids.count
                        while j < jj {
                            let kidRef: Ref = kids[j]
                            if kidRef.num == ref.num && kidRef.gen == ref.gen {
                                break
                            }
                            j += 1
                        }
                        fieldName.insert("`\(j)", at: 0)
                    }
                    namedItem = parent
                    ref = parentRef
                }
                item.fullName = fieldName.joined(separator: ".")
                let alternativeText: String = stringToPDFString(annotation!.get("TU") as? String ?? "")
                item.alternativeText = alternativeText
                let da: String = getInheritableProperty(annotation, "DA") as? String ?? ""
                let regex: Regex<AnyRegexOutput>? = try? Regex("([\\d.]+) Tf")
                let match: Regex<Regex<AnyRegexOutput>.RegexOutput>.Match? = da.firstMatch(of: regex!)
                if match != nil {
                    item.fontSize = floatValue(String(da[match!.range]))
                }
                item.textAlignment = getInheritableProperty(annotation, "Q")
                item.flags = getInheritableProperty(annotation!, "Ff") as? Int ?? 0
            case "Text":
                item.content = stringToPDFString(annotation!.get("Contents") as? String ?? "")
                item.title = stringToPDFString(annotation!.get("T") as? String ?? "")
                item.name = !annotation!.has("Name") ? "Note" : (annotation!.get("Name") as? Name)?.name ?? ""
            default:
                TODO("unimplemented annotation type: " + subtype!.name)
                break
            }
            items.push(item)
        }
        return items
    }
}"###
        @Expect(str1, str2)
    }
}

/* SCAN-IN
    Expect Failed: {COLOR=YELLOW}str1{/COLOR} != {COLOR=YELLOW}str2{/COLOR} (multiline difference below)
         {COLOR=GRAY}class Page {{/COLOR}
        -    var pe: {COLOR=RED}?{/COLOR}PartialEvaluator{COLOR=GREEN}·{/COLOR}
        +    var pe: {COLOR=RED}·{/COLOR}PartialEvaluator{COLOR=GREEN}?{/COLOR}
         ============{COLOR=RED}-{/COLOR}================{COLOR=GREEN}+{/COLOR}
        -    var pageNumber: Int{COLOR=RED}64{/COLOR}
        +    var pageNumber: Int{COLOR=RED}··{/COLOR}
         ======================={COLOR=RED}--{/COLOR}
        -    var pageDict: {COLOR=RED}?{/COLOR}Dict{COLOR=GREEN}·{/COLOR}
        +    var pageDict: {COLOR=RED}·{/COLOR}Dict{COLOR=GREEN}?{/COLOR}
         =================={COLOR=RED}-{/COLOR}===={COLOR=GREEN}+{/COLOR}
         {COLOR=GRAY}    var xref: XRef{/COLOR}
         {COLOR=GRAY}    var ref: Ref{/COLOR}
         {COLOR=GRAY}{/COLOR}
        -    var displayReadyPromise: {COLOR=RED}?{/COLOR}PDFPromise{COLOR=GREEN}·{/COLOR}
        +    var displayReadyPromise: {COLOR=RED}·{/COLOR}PDFPromise{COLOR=GREEN}?{/COLOR}
         ============================={COLOR=RED}-{/COLOR}=========={COLOR=GREEN}+{/COLOR}
         {COLOR=GRAY}{/COLOR}
        -    init({COLOR=GREEN}··{/COLOR}xref: XRef,{COLOR=GREEN}··{/COLOR} pageNumber: Int{COLOR=YELLOW}64,{/COLOR} pageDict: Dict,{COLOR=GREEN}··{/COLOR} ref: Ref) {
        +    init({COLOR=GREEN}_ {/COLOR}xref: XRef,{COLOR=GREEN} _{/COLOR} pageNumber: Int{COLOR=YELLOW}, _{/COLOR} pageDict: Dict,{COLOR=GREEN} _{/COLOR} ref: Ref) {
         ========={COLOR=GREEN}++{/COLOR}==========={COLOR=GREEN}++{/COLOR}================{COLOR=YELLOW}!!!{/COLOR}================{COLOR=GREEN}++{/COLOR}============
        -        {COLOR=YELLOW}this{/COLOR}.pageNumber = pageNumber
        +        {COLOR=YELLOW}self{/COLOR}.pageNumber = pageNumber
         ========{COLOR=YELLOW}!!!!{/COLOR}========================
        -        {COLOR=YELLOW}this{/COLOR}.pageDict = pageDict
        +        {COLOR=YELLOW}self{/COLOR}.pageDict = pageDict
         ========{COLOR=YELLOW}!!!!{/COLOR}====================
        -        {COLOR=YELLOW}this{/COLOR}.xref = xref
        +        {COLOR=YELLOW}self{/COLOR}.xref = xref
         ========{COLOR=YELLOW}!!!!{/COLOR}============
        -        {COLOR=YELLOW}this{/COLOR}.ref = ref
        +        {COLOR=YELLOW}self{/COLOR}.ref = ref
         ========{COLOR=YELLOW}!!!!{/COLOR}==========
         {COLOR=GRAY}{/COLOR}
{COLOR=RED}        -        this.displayReadyPromise = Option<PDFPromise>.None{/COLOR}
{COLOR=GREEN}        +        self.displayReadyPromise = nil{/COLOR}
         {COLOR=GRAY}    }{/COLOR}
         {COLOR=GRAY}{/COLOR}
        -    func getPageProp({COLOR=GREEN}··{/COLOR}key: String) {COLOR=GREEN}·{/COLOR}{COLOR=YELLOW}:{/COLOR} {COLOR=RED}?{/COLOR}Any{COLOR=GREEN}·{/COLOR} {
        +    func getPageProp({COLOR=GREEN}_ {/COLOR}key: String) {COLOR=GREEN}-{/COLOR}{COLOR=YELLOW}>{/COLOR} {COLOR=RED}·{/COLOR}Any{COLOR=GREEN}?{/COLOR} {
         ====================={COLOR=GREEN}++{/COLOR}============={COLOR=GREEN}+{/COLOR}{COLOR=YELLOW}!{/COLOR}={COLOR=RED}-{/COLOR}==={COLOR=GREEN}+{/COLOR}==
{COLOR=RED}        -        return this.pageDict.getOrThrow().get(key){/COLOR}
{COLOR=GREEN}        +        return self.pageDict!.get(key){/COLOR}
         {COLOR=GRAY}    }{/COLOR}
         {COLOR=GRAY}{/COLOR}
        -    func inheritPageProp({COLOR=GREEN}··{/COLOR}key: String) {COLOR=GREEN}·{/COLOR}{COLOR=YELLOW}:{/COLOR} {COLOR=RED}?{/COLOR}Any{COLOR=GREEN}·{/COLOR} {
        +    func inheritPageProp({COLOR=GREEN}_ {/COLOR}key: String) {COLOR=GREEN}-{/COLOR}{COLOR=YELLOW}>{/COLOR} {COLOR=RED}·{/COLOR}Any{COLOR=GREEN}?{/COLOR} {
         ========================={COLOR=GREEN}++{/COLOR}============={COLOR=GREEN}+{/COLOR}{COLOR=YELLOW}!{/COLOR}={COLOR=RED}-{/COLOR}==={COLOR=GREEN}+{/COLOR}==
        -        var dict: {COLOR=RED}?{/COLOR}Dict{COLOR=GREEN}·{/COLOR} = {COLOR=YELLOW}this{/COLOR}.pageDict
        +        var dict: {COLOR=RED}·{/COLOR}Dict{COLOR=GREEN}?{/COLOR} = {COLOR=YELLOW}self{/COLOR}.pageDict
         =================={COLOR=RED}-{/COLOR}===={COLOR=GREEN}+{/COLOR}==={COLOR=YELLOW}!!!!{/COLOR}=========
{COLOR=RED}        -        var obj: ?Any = dict.getOrThrow().get(key){/COLOR}
{COLOR=RED}        -        while ( obj.isNone()) {{/COLOR}
{COLOR=RED}        -            dict = dict.getOrThrow().get("Parent").getOrThrow() as Dict{/COLOR}
{COLOR=RED}        -            if ( dict.isNone()) {{/COLOR}
{COLOR=RED}        -                break  //???{/COLOR}
{COLOR=GREEN}        +        var obj: Any? = dict!.get(key){/COLOR}
{COLOR=GREEN}        +        while obj == nil {{/COLOR}
{COLOR=GREEN}        +            dict = dict!.get("Parent") as? Dict{/COLOR}
{COLOR=GREEN}        +            if dict == nil {{/COLOR}
{COLOR=GREEN}        +                break{/COLOR}
         {COLOR=GRAY}            }{/COLOR}
{COLOR=RED}        -            obj = dict.getOrThrow().get(key){/COLOR}
{COLOR=GREEN}        +            obj = dict!.get(key){/COLOR}
         {COLOR=GRAY}        }{/COLOR}
{COLOR=GRAY}        (...2 equal lines skipped...){/COLOR}
         {COLOR=GRAY}{/COLOR}
{COLOR=RED}        -    prop content: ?Any {{/COLOR}
{COLOR=RED}        -        get() {{/COLOR}
{COLOR=GREEN}        +    var content: Any? {{/COLOR}
        -{COLOR=RED}    {/COLOR}        return {COLOR=YELLOW}this{/COLOR}.getPageProp("Contents")
        +{COLOR=RED}····{/COLOR}        return {COLOR=YELLOW}self{/COLOR}.getPageProp("Contents")
         {COLOR=RED}----{/COLOR}==============={COLOR=YELLOW}!!!!{/COLOR}========================
{COLOR=RED}        -        }{/COLOR}
         {COLOR=GRAY}    }{/COLOR}
         {COLOR=GRAY}{/COLOR}
        -    {COLOR=GREEN}·{/COLOR}{COLOR=YELLOW}p{/COLOR}r{COLOR=RED}op{/COLOR} resources: {COLOR=RED}?{/COLOR}Any{COLOR=GREEN}·{/COLOR} {
        +    {COLOR=GREEN}v{/COLOR}{COLOR=YELLOW}a{/COLOR}r{COLOR=RED}··{/COLOR} resources: {COLOR=RED}·{/COLOR}Any{COLOR=GREEN}?{/COLOR} {
         ===={COLOR=GREEN}+{/COLOR}{COLOR=YELLOW}!{/COLOR}={COLOR=RED}--{/COLOR}============{COLOR=RED}-{/COLOR}==={COLOR=GREEN}+{/COLOR}==
{COLOR=RED}        -        get() {{/COLOR}
        -{COLOR=RED}    {/COLOR}        return {COLOR=YELLOW}this{/COLOR}.getPageProp("Resources")
        +{COLOR=RED}····{/COLOR}        return {COLOR=YELLOW}self{/COLOR}.getPageProp("Resources")
         {COLOR=RED}----{/COLOR}==============={COLOR=YELLOW}!!!!{/COLOR}=========================
{COLOR=RED}        -        }{/COLOR}
         {COLOR=GRAY}    }{/COLOR}
         {COLOR=GRAY}{/COLOR}
{COLOR=RED}        -    prop mediaBox: ArrayList<Float32> {{/COLOR}
{COLOR=RED}        -        get() {{/COLOR}
{COLOR=GREEN}        +    var mediaBox: [Float] {{/COLOR}
        -{COLOR=RED}    {/COLOR}        var obj: {COLOR=RED}?{/COLOR}Any{COLOR=GREEN}·{/COLOR} = {COLOR=YELLOW}this{/COLOR}.inheritPageProp("MediaBox")
        +{COLOR=RED}····{/COLOR}        var obj: {COLOR=RED}·{/COLOR}Any{COLOR=GREEN}?{/COLOR} = {COLOR=YELLOW}self{/COLOR}.inheritPageProp("MediaBox")
         {COLOR=RED}----{/COLOR}================={COLOR=RED}-{/COLOR}==={COLOR=GREEN}+{/COLOR}==={COLOR=YELLOW}!!!!{/COLOR}============================
{COLOR=GREEN}        +        if !isArray(obj as Any) || (obj as? [Float])?.count != 4 {{/COLOR}
{COLOR=GREEN}        +            obj = [0.0, 0.0, 612.0, 792.0].map { Float($0) }{/COLOR}
{COLOR=GREEN}        +        }{/COLOR}
{COLOR=GREEN}        +        return obj as! [Float]{/COLOR}
{COLOR=GREEN}        +    }{/COLOR}
{COLOR=GRAY}        (...further 206 lines are omitted){/COLOR}
 */
