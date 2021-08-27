Class {
	#name : #RLGrid,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'ReinforcementLearning-Core'
}

{ #category : #comparing }
RLGrid >> = anotherObject [
	"Return true if anotherObject is the same map than myself"
	anotherObject class == self class ifFalse: [ ^ false ].
	^ content = anotherObject content
]

{ #category : #accessing }
RLGrid >> at: y at: x [
	^ (content at: y) at: x
]

{ #category : #accessing }
RLGrid >> at: y at: x put: aValue [
	^ (content at: y) at: x put: aValue
]

{ #category : #accessing }
RLGrid >> atPosition: aPoint [
	"Return the character located at a given position"
	^ (content at: aPoint y) at: aPoint x
]

{ #category : #accessing }
RLGrid >> atPosition: aPoint put: aCharacter [
	"Set the aCharacter (value of a cell map) at a given position"
	^ (content at: aPoint y) at: aPoint x put: aCharacter
]

{ #category : #accessing }
RLGrid >> content [
	"Return the grid content, as an array of array of characters"
	^ content
]

{ #category : #accessing }
RLGrid >> contentAsString [
	^ '' join: (content collect: [ :l | '' join: l ])
]

{ #category : #accessing }
RLGrid >> extent [
	"Return a point that represents the extent of the grid"
	^ content first size @ content size 
]

{ #category : #comparing }
RLGrid >> hash [
	"The hash of a grid is the hash of its content"
	^ content hash
]

{ #category : #initialization }
RLGrid >> initialize [
	super initialize.
	self setSize: 2
]

{ #category : #visualization }
RLGrid >> inspectorVisualization [
	<inspectorPresentationOrder: 90 title: 'Visualization'>
	| canvas |
	canvas := self visualize.
	canvas @ RSCanvasController.
	^ SpRoassal3InspectorPresenter new
		canvas: canvas;
		yourself
]

{ #category : #accessing }
RLGrid >> numberOfZombies [
	^ ((content flatCollect: #yourself) select: [ :c | c = $z ]) size
]

{ #category : #copying }
RLGrid >> postCopy [
	"A grid must be properly copied"
	super postCopy.
	content := content copy
]

{ #category : #printing }
RLGrid >> printOn: str [
	content do: [ :row |
		str nextPutAll: ('' join: row); cr ]
]

{ #category : #initialization }
RLGrid >> setContent: aContentAsString [
	"Set the content of the grid using a String"
	| e index sideLength |
	sideLength := aContentAsString size sqrt.
	self setSize: sideLength.
	index := 1.
	1 to: sideLength do: [ :y |
		1 to: sideLength do: [ :x |
			self at: y at: x put: (aContentAsString at: index).
			index := index + 1 ] ]
]

{ #category : #'as yet unclassified' }
RLGrid >> setExitBottomRight [
	"Set the exit position at the bottom right of the grid"
	self atPosition: self extent put: $e
]

{ #category : #initialization }
RLGrid >> setIceCreamBottomRight [
	self atPosition: self extent put: $i
]

{ #category : #'as yet unclassified' }
RLGrid >> setMonsters: numberOfMonstersToAdd [
	| random leftMonsters s pos nbTries |
	random := Random seed: 42.
	leftMonsters := numberOfMonstersToAdd.
	nbTries := 0.
	s := self extent.
	[ leftMonsters > 0 ] whileTrue: [ 
		pos := (random nextInteger: s x ) @ (random nextInteger: s y).
		(self atPosition: pos) = $. 
			ifTrue: [ 
				nbTries := 0.
				self atPosition: pos put: $m.
				leftMonsters := leftMonsters - 1 ]
			ifFalse: [ 
				nbTries := nbTries + 1. 
				nbTries > 5 ifTrue: [ ^ self ] ]
	]
]

{ #category : #initialization }
RLGrid >> setSize: anInteger [
	"Set the grid as a square of size anInteger, containing the character $."
	content := (1 to: anInteger) collect: [ :notUsed | Array new: anInteger withAll: $. ] as: Array.
	self setExitBottomRight.
]

{ #category : #initialization }
RLGrid >> setZombies: numberOfZombiesToAdd [
	| random numberOfZombiesLeftToAdd s pos |
	random := Random seed: 42.
	numberOfZombiesLeftToAdd := numberOfZombiesToAdd.
	s := self extent.
	[ numberOfZombiesLeftToAdd > 0 ] whileTrue: [ 
		pos := (random nextInteger: s x ) @ (random nextInteger: s y).
		(self atPosition: pos) = $. ifTrue: [ 
			self atPosition: pos put: $z.
			numberOfZombiesLeftToAdd := numberOfZombiesLeftToAdd - 1 ]
	]
]

{ #category : #visualization }
RLGrid >> visualize [
	| canvas shapes |
	canvas := RSCanvas new.
	shapes := RSBox models: (self content flatCollect: #yourself) forEach: [ :s :o |
		s size: 20.
		o = $. ifTrue: [ s color: Color veryVeryLightGray ].
		o = $m ifTrue: [ s color: Color lightRed ].
		o = $e ifTrue: [ s color: Color lightYellow ].
		 ].
	canvas addAll: shapes.
	RSGridLayout new gapSize: 0; lineItemsCount: (self extent x); on: shapes.
	shapes translateTopLeftTo: 0 @ 0.
	^ canvas
]
