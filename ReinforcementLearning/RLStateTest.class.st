Class {
	#name : #RLStateTest,
	#superclass : #TestCase,
	#category : #'ReinforcementLearning-Tests'
}

{ #category : #equality }
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

{ #category : #equality }
RLStateTest >> testEquals01 [
	| s1 s2 |
	s1 := RLState new.
	s2 := RLState new.
	self assert: s1 = s2.
]

{ #category : #equality }
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

{ #category : #equality }
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

{ #category : #'car position' }
RLStateTest >> testInitialCarPosition [

	| s |
	s := RLState new.
	self assert: s position equals: 1 @ 1
]

{ #category : #'car position' }
RLStateTest >> testInitialCarPosition02 [

	| s |
	s := RLState new.
	s position: 6 @ 100.
	self assert: s position equals: 6 @ 100
]

{ #category : #'car position' }
RLStateTest >> testInitialCarPosition03 [

	| s |
	s := RLState new.
	s grid: (RLGrid new).
	s position: 1 @ 2.
	self assert: s position equals: 1 @ 2
]

{ #category : #visualization }
RLStateTest >> testVisualize01 [

	| s c |
	s := RLState new.
	s grid: (RLGrid new).
	c := s visualize.
	self assert: c class equals: RSCanvas.
	self assert: c numberOfShapes equals: 5.
]

{ #category : #visualization }
RLStateTest >> testVisualize03 [

	| s c |
	s := RLState new.
	s grid: RLGrid new.
	c := s visualize.
	self assert: c class equals: RSCanvas.
	self assert: c numberOfShapes equals: 5.
]

{ #category : #visualization }
RLStateTest >> testVisualize04 [

	| s c |
	s := RLState new grid: (RLGrid new setContent: '.zz....zi').
	c := s visualize.
	self assert: c class equals: RSCanvas.
	self assert: c numberOfShapes equals: 10.
]

{ #category : #visualization }
RLStateTest >> testVisualize05 [

	| s c |
	s := RLState new grid: (RLGrid new setContent: '.zz....zi').
	s position: 2 @ 2.
	c := s visualize.
	self assert: c class equals: RSCanvas.
	self assert: c numberOfShapes equals: 10.
]
