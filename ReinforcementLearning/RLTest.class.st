Class {
	#name : #RLTest,
	#superclass : #TestCase,
	#category : #ReinforcementLearning
}

{ #category : #tests }
RLTest >> testContent [

	| g cc |
	g := RLGrid new.
	cc := g content flatCollect: #yourself.
	self assert: cc size equals: 4.
	self assert: cc equals: (Array new: 4 withAll: $.)
]

{ #category : #tests }
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
	self assert: result equals: #(-100 994 997 996 999 998 999 999 999 999 999 999 999 999 997 998 999 999 999 998)
]

{ #category : #'tests - engine' }
RLTest >> testEngineIfLearnt [

	| rl |
	rl := RL new.
	rl setInitialContent: 'i.z.'.
	rl run.
	rl setInitialContent: 'i.z.'.
	self assert: rl carPosition equals: 2 @ 2.
	rl actOnBestAction.
	self assert: rl carPosition equals: 2 @ 1.
	rl actOnBestAction.
	self assert: rl carPosition equals: 1 @ 1.
]

{ #category : #tests }
RLTest >> testGrid [

	| g |
	g := RLGrid new.
	self assert: g content size equals: 2.
	self assert: (g content collect: #size) asSet asArray equals: #(2).
	self assert: g extent equals: 2 @ 2
]

{ #category : #tests }
RLTest >> testGrid02 [

	| g |
	g := RLGrid new.
	g setSize: 10.
	self assert: g content size equals: 10.
	self assert: (g content collect: #size) asSet asArray equals: #(10)
]

{ #category : #tests }
RLTest >> testGridPrinting [

	| g |
	g := RLGrid new.
	self assert: g printString equals:
'..
..
'
]

{ #category : #tests }
RLTest >> testGridSetContent [

	| g |
	g := RLGrid new.
	g setContent: 'i*zc'.
	self assert: g printString equals:
'i*
zc
'
]

{ #category : #tests }
RLTest >> testZombie [

	| grid |
	grid := RLGrid new.
	grid setContent: 'i*zc'.
	


]
