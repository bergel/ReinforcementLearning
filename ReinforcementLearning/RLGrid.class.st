Class {
	#name : #RLGrid,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #ReinforcementLearning
}

{ #category : #comparing }
RLGrid >> = anotherObject [
	anotherObject class ~= self class ifTrue: [ ^ false ].
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
	^ self at: aPoint y at: aPoint x
]

{ #category : #accessing }
RLGrid >> atPosition: aPoint put: aValue [
	^ self at: aPoint y at: aPoint x put: aValue
]

{ #category : #accessing }
RLGrid >> content [
	^ content
]

{ #category : #accessing }
RLGrid >> contentAsString [
	^ '' join: (content collect: [ :l | '' join: l ])
]

{ #category : #accessing }
RLGrid >> extent [
	"Return a point"
	^ content first size @ content size 
]

{ #category : #comparing }
RLGrid >> hash [
	^ content hash
]

{ #category : #initialization }
RLGrid >> initialize [
	super initialize.
	self setSize: 2
]

{ #category : #accessing }
RLGrid >> numberOfZombies [
	^ ((content flatCollect: #yourself) select: [ :c | c = $z ]) size
]

{ #category : #copying }
RLGrid >> postCopy [
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

{ #category : #initialization }
RLGrid >> setIceCreamBottomRight [
	self atPosition: self extent put: $i
]

{ #category : #initialization }
RLGrid >> setSize: anInteger [
	"Set the grid as a square of size anInteger"
	content := (1 to: anInteger) collect: [ :notUsed | Array new: anInteger withAll: $. ] as: Array
	
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
