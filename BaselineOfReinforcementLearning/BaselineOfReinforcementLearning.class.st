Class {
	#name : #BaselineOfReinforcementLearning,
	#superclass : #BaselineOf,
	#category : #BaselineOfReinforcementLearning
}

{ #category : #baselines }
BaselineOfReinforcementLearning >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			package: #'ReinforcementLearning'.
		spec 
			group: 'default' with: #('ReinforcementLearning' ). ].

]
