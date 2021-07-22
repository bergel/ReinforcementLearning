Class {
	#name : #RLTest,
	#superclass : #TestCase,
	#category : #ReinforcementLearning
}

{ #category : #'test - grid' }
RLTest >> testContent [

	| g cc |
	g := RLGrid new.
	cc := g content flatCollect: #yourself.
	self assert: cc size equals: 4.
	self assert: cc equals: (Array new: 4 withAll: $.)
]

{ #category : #'test - grid' }
RLTest >> testContent02 [

	| g |
	g := RLGrid new.
	self assert: (g at: 1 at: 1) equals: $..
	g at: 1 at: 1 put: 2.
	self assert: (g at: 1 at: 1) equals: 2.
]

{ #category : #'tests - engine' }
RLTest >> testEngine [

	| result |
	result := RL new run.
	self assert: result equals: #(-104 997 999 999 999 999 998 999 999 998 999 999 999 999 999 998 998 -100 999 997)
]

{ #category : #'tests - engine' }
RLTest >> testEngineIfLearnt [

	| rl |
	rl := RL new.
	rl setInitialContent: '.z.i'.
	rl run.
	rl setInitialContent: '.z.i'.
	self assert: rl carPosition equals: 1 @ 1.
	rl actOnBestAction.
	self assert: rl carPosition equals: 1 @ 2.
	rl actOnBestAction.
	self assert: rl carPosition equals: 2 @ 2.
]

{ #category : #'test - grid' }
RLTest >> testGrid [

	| g |
	g := RLGrid new.
	self assert: g content size equals: 2.
	self assert: (g content collect: #size) asSet asArray equals: #(2).
	self assert: g extent equals: 2 @ 2
]

{ #category : #'test - grid' }
RLTest >> testGrid02 [

	| g |
	g := RLGrid new.
	g setSize: 10.
	self assert: g content size equals: 10.
	self assert: (g content collect: #size) asSet asArray equals: #(10)
]

{ #category : #'test - grid' }
RLTest >> testGridPrinting [

	| g |
	g := RLGrid new.
	self assert: g printString equals:
'..
..
'
]

{ #category : #'test - grid' }
RLTest >> testGridSetContent [

	| g |
	g := RLGrid new.
	g setContent: 'i*zc'.
	self assert: g printString equals:
'i*
zc
'
]

{ #category : #'test - grid' }
RLTest >> testNumberOfZombies [
	| grid |
	grid := RLGrid new setContent: 'i.z.'.
	self assert: grid numberOfZombies equals: 1
]

{ #category : #'test - grid' }
RLTest >> testNumberOfZombies02 [
	self assert: RLGrid new numberOfZombies equals: 0
]

{ #category : #'test - grid' }
RLTest >> testNumberOfZombies03 [
	self assert: (RLGrid new setSize: 20; setZombies: 5; numberOfZombies) equals: 5
]

{ #category : #'test - grid' }
RLTest >> testSetContent [

	| grid |
	grid := RLGrid new setContent: '.zzz....i'.
	self assert: grid extent equals: 3 @ 3.
	self assert: grid contentAsString equals: '.zzz....i'.
	
]
