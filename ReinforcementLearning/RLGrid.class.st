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

{ #category : #initialization }
RLGrid >> content [
	^ content
]

{ #category : #initialization }
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
RLGrid >> setContent: aContent [
	| e index |
	e := self extent.
	index := 1.
	1 to: e y do: [ :y |
		1 to: e x do: [ :x |
			self at: y at: x put: (aContent at: index).
			index := index + 1 ] ]
]

{ #category : #initialization }
RLGrid >> setSize: anInteger [
	content := (1 to: anInteger) collect: [ :notUsed | Array new: anInteger withAll: $. ] as: Array
	
]
