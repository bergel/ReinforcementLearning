Class {
	#name : #RLGrid,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #ReinforcementLearning
}

{ #category : #accessing }
RLGrid >> at: y at: x [
	^ (content at: y) at: x
]

{ #category : #accessing }
RLGrid >> at: y at: x put: aValue [
	^ (content at: y) at: x put: aValue
]

{ #category : #initialization }
RLGrid >> content [
	^ content
]

{ #category : #initialization }
RLGrid >> extent [
	^ content first size @ content size 
]

{ #category : #initialization }
RLGrid >> initialize [
	super initialize.
	self setSize: 2
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
