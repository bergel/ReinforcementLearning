# Reinforcement Learning in Pharo

[![Tests](https://github.com/bergel/ReinforcementLearning/actions/workflows/runTests.yml/badge.svg)](https://github.com/bergel/ReinforcementLearning/actions/workflows/runTests.yml)
[![UML Class diagram](https://github.com/bergel/ReinforcementLearning/actions/workflows/visualizeClassDiagram.yml/badge.svg)](https://github.com/bergel/ReinforcementLearning/blob/main/ci_data/uml.png)

Reinforcement learning is a machine learning algorithm that (i) explores a graph made of states and actions, and (ii) identifies an optimal route in this graph based on a reward mechanism. The code contained in this repository implements the Q-Learning algorithm. Its implementation is simple and provides some visualizations. The UML Class diagram of this project is [available online](https://github.com/bergel/ReinforcementLearning/blob/main/ci_data/uml.png).

The content of this repository is designed to run on the [Pharo programming language](https://pharo.org). The code provided in this repository is part of the book titled _Agile Visualization with Pharo -- Crafting Interactive Visual Support Using Roassal_, published by APress.

-----
## Installation

The project is known to work on Pharo 9 and Pharo 10. Open a workspace and run the following:

```Smalltalk
[ Metacello new
    baseline: 'ReinforcementLearning';
    repository: 'github://bergel/ReinforcementLearning:main';
    load ] on: MCMergeOrLoadWarning do: [ :warning | warning load ]
```
------
## Screenshots

Here are some screenshots of the visualization to illustrates the execution of the Q-Learning algorithm. The example describes the classical scenario where a knight need to exit a map while avoiding monsters. Here is the solution that shows the path from the starting point (large blue dot) toward the exit (yellow cell), while avoiding monsters (light red cells):

<img width="595" alt="image" src="https://user-images.githubusercontent.com/393742/131110454-6b1e3313-795c-4459-9a2d-446ba4f6d4d8.png">

Here is the Q-Table that indicates the rewards of each actions for all the states:

<img width="593" alt="image" src="https://user-images.githubusercontent.com/393742/131110732-3b88f579-f4f4-4680-aa54-24c7488d673e.png">

The culumated reward along the episodes:

<img width="591" alt="image" src="https://user-images.githubusercontent.com/393742/131110812-af535c4f-062f-4de0-aaf4-b20b00a901c2.png">

Q-Learning, as any Reinforcement Learning algorithm, explores a graph composed of nodes (states) and edges (actions leading to a state transition). The graph is also visually represented:

<img width="590" alt="image" src="https://user-images.githubusercontent.com/393742/131110990-86298e0d-26d8-4eb3-8e9b-96fef6d2edb0.png">


