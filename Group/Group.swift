//
//  Group.swift
//  Group
//
//  Created by fgtrjhyu on 2015/04/06.
//  Copyright (c) 2015年 fgtrjhyu. All rights reserved.
//

public class Group<T>: SequenceType {
    
    let equivalent: (T, T) -> Bool
    
    var first: Represent<T>?
    
    public init(equivalent e: (T, T) -> Bool) {
        equivalent = e
    }
    
    public func add(items: T...) {
        for item in items {
            let m = Member(parent: self, value: item)
            if let first = first {
                first.add(other: m)
            } else {
                first = Represent(first: m)
            }
        }
    }
    
    private func equiv(that: Member<T>, other: Member<T>) -> Bool {
        return equivalent(that.value, other.value)
    }
    
    public func generate() -> RepresentGenerator<T> {
        return RepresentGenerator<T>(current: first)
    }
}

public class Represent<T>: SequenceType {
    
    var next: Represent<T>?
    
    public let first: Member<T>
    
    init(first f: Member<T>) {
        first = f
    }
    
    func add(other o: Member<T>) {
        if first.equiv(other: o) {
            first.add(member: o)
        } else if let next = next {
            next.add(other: o)
        } else {
            next = Represent(first: o)
        }
    }

    public func generate() -> MemberGenerator<T> {
        return MemberGenerator<T>(current: first)
    }
}

public class Member<T> {
    
    var next: Member<T>?
    
    let parent: Group<T>

    public let value: T
    
    init(parent p: Group<T>, value v: T) {
        parent = p
        value = v
    }
    
    func equiv(other o: Member<T>) -> Bool {
        return parent.equiv(self, other:o)
    }
    
    func add(member m: Member<T>) {
        if let next = next {
            next.add(member: m)
        } else {
            next = m
        }
    }
    
}

public class RepresentGenerator<T>: GeneratorType {
    var current: Represent<T>?
    
    init(current c: Represent<T>?) {
        current = c
    }
    
    public func next() -> Represent<T>? {
        let result: Represent<T>? = current
        current = current?.next
        return result
    }
}

public class MemberGenerator<T>: GeneratorType {

    var current: Member<T>?
    
    init(current c: Member<T>) {
        current = c
    }
    
    public func next() -> Member<T>? {
        let result: Member<T>? = current
        current = current?.next
        return result
    }
}