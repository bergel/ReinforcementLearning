Class {
	#name : #RLTest,
	#superclass : #TestCase,
	#category : #'ReinforcementLearning-Tests'
}

{ #category : #'tests - engine' }
RLTest >> testEngine [

	| result grid rl |
	grid := RLGrid new setContent:  '.z.i'.
	rl := RL new setInitialGrid: grid.
	result := rl run.
	self assert: result equals: #(-104 997 999 999 999 999 998 999 999 998 999 999 999 999 999 998 998 -100 999 997).
	
	self assert: rl play equals: {(1@1). (1@2). (2@2)}
]

{ #category : #'tests - engine' }
RLTest >> testEngine02 [

	| result rl |
	rl := RL new setInitialGrid: (RLGrid new setContent: '.zz....zi').
	rl numberOfEpisodes: 50.
	result := rl run.
	
	self assert: result equals: #(-104 -103 -103 -102 -111 983 993 995 -100 997 997 997 997 997 997 996 997 997 -102 -100 996 997 996 997 997 997 -104 997 996 997 996 -102 997 997 997 -100 996 997 996 995 997 995 997 997 996 996 -102 997 997 -100).
	
	self assert: rl play equals: {(1@1). (1@2). (2@2). (3@2). (3@3)}
]

{ #category : #'tests - examples' }
RLTest >> testExamples [
	| r |
	r := RLExample new exampleZombie.
	self assert: r equals: #(-104 -102 -100 995 -104 993 999 999 999 999 997 998 -100 999 997 999 -100 996 999 -100).
	
	r := RLExample new exampleZombie02.
	self assert: r equals: #(-104 -103 -106 -103 -102 -120 -108 -107 -141 -104 -112 -104 -109 -105 -104 -106 -112 -112 -134 -106 -105 -106 -104 -104 985 -101 -105 -102 997 991 997 997 997 997 995 996 997 997 996 997 997 995 997 997 997 -102 997 996 996 -102)
]
