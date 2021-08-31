Class {
	#name : #RLGridTest,
	#superclass : #TestCase,
	#category : #'ReinforcementLearning-Tests'
}

{ #category : #'test - grid' }
RLGridTest >> testContent [

	| g cc |
	g := RLGrid new.
	cc := g content flatCollect: #yourself.
	self assert: cc size equals: 4.
	self assert: cc equals: #($. $. $. $e)
]

{ #category : #'test - grid' }
RLGridTest >> testContent02 [

	| g |
	g := RLGrid new.
	self assert: (g at: 1 at: 1) equals: $..
	g at: 1 at: 1 put: 2.
	self assert: (g at: 1 at: 1) equals: 2.
]

{ #category : #'test - grid' }
RLGridTest >> testGrid [

	| g |
	g := RLGrid new.
	self assert: g content size equals: 2.
	self assert: (g content collect: #size) asSet asArray equals: #(2).
	self assert: g extent equals: 2 @ 2
]

{ #category : #'test - grid' }
RLGridTest >> testGrid02 [

	| g |
	g := RLGrid new.
	g setSize: 10.
	self assert: g content size equals: 10.
	self assert: (g content collect: #size) asSet asArray equals: #(10)
]

{ #category : #'test - grid' }
RLGridTest >> testGridPrinting [

	| g |
	g := RLGrid new.
	self assert: g printString equals:
'..
.e
'
]

{ #category : #'test - grid' }
RLGridTest >> testGridSetContent [

	| g |
	g := RLGrid new.
	g setContent: 'i*zc'.
	self assert: g printString equals:
'i*
zc
'
]

{ #category : #'test - grid' }
RLGridTest >> testNumberOfZombies [
	| grid |
	grid := RLGrid new setContent: 'i.z.'.
	self assert: grid numberOfZombies equals: 1
]

{ #category : #'test - grid' }
RLGridTest >> testNumberOfZombies02 [
	self assert: RLGrid new numberOfZombies equals: 0
]

{ #category : #'test - grid' }
RLGridTest >> testNumberOfZombies03 [
	self assert: (RLGrid new setSize: 20; setZombies: 5; numberOfZombies) equals: 5
]

{ #category : #'test - grid' }
RLGridTest >> testSetContent [

	| grid |
	grid := RLGrid new setContent: '.zzz....i'.
	self assert: grid extent equals: 3 @ 3.
	self assert: grid contentAsString equals: '.zzz....i'.
	
]

{ #category : #visualization }
RLGridTest >> testVisualization01 [

	| g c |
	g := RLGrid new.
	c := g visualize.
	self assert: c class equals: RSCanvas.
	self assert: c numberOfShapes equals: g contentAsString size
]

{ #category : #tests }
RLGridTest >> testVisualizations [

	| grid visualizationSelectors |
	grid := RLGrid new setContent:  '.m.e'.

	visualizationSelectors := grid class selectors select: [ :sel | sel beginsWith: 'visualize' ].
	visualizationSelectors do: [ :k | 
		grid perform: k ].
	
	visualizationSelectors := grid class selectors select: [ :sel | sel beginsWith: 'inspector' ].
	visualizationSelectors do: [ :k | 
		grid perform: k withEnoughArguments: {  StInspectionContext new } ].
	

]
