Class {
	#name : #RL,
	#superclass : #Object,
	#instVars : [
		'numberOfEpisodes',
		'maxEpisodeSteps',
		'minAlpha',
		'gamma',
		'eps',
		'qTable',
		'currentState',
		'isDone',
		'currentReward',
		'totalReward',
		'nextState',
		'r',
		'startState'
	],
	#category : #ReinforcementLearning
}

{ #category : #running }
RL >> act: action [

	| newGrid newCarPosition gridItem |
	newCarPosition := self newCarPosition: action.
	gridItem := currentState grid atPosition: newCarPosition.
	newGrid := currentState grid copy.
	gridItem = $z ifTrue: [ currentReward := -100. isDone := true ].
	gridItem = $i ifTrue: [ currentReward := 1000. isDone := true ].
	('zi' includes: gridItem) ifFalse: [ currentReward := -1. isDone := false ].
"	gridItem = $. ifTrue: [ currentReward := -1. isDone := false. 
		newGrid atPosition: currentState position put: $. .
		newGrid atPosition: newCarPosition put: $c ]."
	"gridItem = $c ifTrue: [ currentReward := -1. isDone := false ]."
	totalReward := totalReward + currentReward.
	nextState := RLState new grid: newGrid; position: newCarPosition.
	
]

{ #category : #running }
RL >> actOnBestAction [
	self act: self bestAction.
	currentState := nextState.
]

{ #category : #running }
RL >> actions [
	"Return the considered actions"
	^ #(1 2 3 4)
]

{ #category : #running }
RL >> bestAction [

	^ (self qState: currentState) argmax
]

{ #category : #running }
RL >> carPosition [
	^ currentState position
]

{ #category : #running }
RL >> checkForNewState: aState [

	qTable at: aState ifAbsentPut: [ self newQTableRow ]
]

{ #category : #running }
RL >> chooseAction [

	"Return the actions to be executed, i.e., a number between 1 and `self numberOfActions`"

	^ r next < eps
		  ifTrue: [ self actions atRandom: r ]
		  ifFalse: [ self bestAction ]
]

{ #category : #running }
RL >> initialize [
	super initialize.
	r := Random seed: 42.
	isDone := false.
	currentReward := 0.
	totalReward := 0.
	numberOfEpisodes := 20.
	maxEpisodeSteps := 100.
	minAlpha := 0.02.
	gamma := 1.0.
	eps := 0.2.
	qTable := Dictionary new.
	
	"Initialize the engine with the very simple map"
	self setInitialContent: 'i.zc'
]

{ #category : #running }
RL >> newCarPosition: action [
	"Return the new position of a car, as a point. The action is a number from 1 to 4.
	**Maybe we should have a RLCar class**
	return a new position"
	| delta |
	delta := { 0@ -1 . 0@1 . -1@0 . 1@0 } at: action ifAbsent: [ self error: 'Unknown action' ].
	^ ((currentState position + delta) min: currentState grid extent) max: 1 @ 1

]

{ #category : #running }
RL >> newQTableRow [

	^ (1 to: self numberOfActions) collect: [ :nU | 0 ]
]

{ #category : #running }
RL >> numberOfActions [
	^ self actions size
]

{ #category : #running }
RL >> qState: aState [

	self checkForNewState: aState.
	^ qTable at: aState
]

{ #category : #running }
RL >> qState: aState action: anAction [

	self checkForNewState: aState.
	^ (qTable at: aState) at: anAction
]

{ #category : #running }
RL >> run [
	<script: 'self new run'>
	| alphas currentAction result alpha |
	"
	actionUP := 1.
	actionDown := 2.
	actionLeft := 3.
	actionRight := 4.
	"
	alphas := (minAlpha to: 1.0 count: numberOfEpisodes) reversed.

	result := OrderedCollection new.
	1 to: numberOfEpisodes do: [ :e |
		currentState := startState.
		totalReward := 0.
		alpha := alphas at: e.
		isDone := false.
		maxEpisodeSteps timesRepeat: [ 
			isDone ifFalse: [ 
				currentAction := self chooseAction.
				self act: currentAction.
				
				(self qState: currentState) at: currentAction put: (
					(self qState: currentState action: currentAction) + (alpha * (currentReward + (gamma * (self qState: nextState) max) - (self qState: currentState action: currentAction)))).
				currentState := nextState
			]
		].
		Transcript show: ('Episode {1}: total reward -> {2}' format: { e . totalReward }); cr.
		result add: totalReward 
	].
	^ result asArray












]

{ #category : #running }
RL >> setInitialContent: aString [
	startState := RLState new grid: (RLGrid new setContent: aString); position: 2 @ 2.
	currentState := startState
]
