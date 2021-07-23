Class {
	#name : #RLStateTest,
	#superclass : #TestCase,
	#category : #'ReinforcementLearning-Tests'
}

{ #category : #tests }
RLStateTest >> testDictionary [
	| s1 s2 s3 grid d |
	grid := RLGrid new.
	s1 := RLState new grid: grid; position: 1 @ 1.
	s2 := RLState new grid: grid copy; position: 1 @ 1.
	s3 := RLState new grid: grid copy; position: 1 @ 2.
	
	d := Dictionary new.
	d at: s1 put: 42.
	self assert: (d at: s1) equals: 42.
	self assert: (d at: s2) equals: 42.
	self deny: (d includesKey: s3)

]

{ #category : #tests }
RLStateTest >> testEquals01 [
	| s1 s2 |
	s1 := RLState new.
	s2 := RLState new.
	self assert: s1 = s2.
]

{ #category : #tests }
RLStateTest >> testEquals02 [
	| s1 s2 s3 grid |
	grid := RLGrid new.
	s1 := RLState new grid: grid.
	s2 := RLState new grid: grid.
	s3 := RLState new.
	self assert: s1 = s2.
	self assert: s1 ~= s3.
	self assert: s2 ~= s3.
	
	self assert: s1 asString = s2 asString.
	self assert: s3 asString ~= s1 asString.
]

{ #category : #tests }
RLStateTest >> testEquals03 [
	| s1 s2 s3 grid |
	grid := RLGrid new.
	s1 := RLState new grid: grid; position: 1 @ 1.
	s2 := RLState new grid: grid copy; position: 1 @ 1.
	s3 := RLState new grid: grid copy; position: 1 @ 2.
	self assert: s1 = s2.
	self assert: s1 ~= s3.
	self assert: s2 ~= s3.

	self assert: s1 hash = s2 hash.
	self assert: s1 hash ~= s3 hash.
	self assert: s2 hash ~= s3 hash.
	
	self assert: s1 asString = s2 asString.
	self assert: s3 asString ~= s1 asString.
]
