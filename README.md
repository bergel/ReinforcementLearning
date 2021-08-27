# Reinforcement Learning in Pharo

[![Tests](https://github.com/bergel/ReinforcementLearning/actions/workflows/runTest.yml/badge.svg)](https://github.com/bergel/ReinforcementLearning/actions/workflows/runTest.yml)
[![Coverage](https://raw.githubusercontent.com/bergel/ReinforcementLearning/main/ci_data/coverageBadge.svg)](https://github.com/bergel/ReinforcementLearning/blob/main/ci_data/coverage.png)

Reinforcement learning is a machine learning algorithm that (i) explores a graph made of states and actions, and (ii) identifies an optimal route in this graph based on a reward mechanism. The code contained in this repository implements the Q-Learning algorithm. It is simple and provides some visualization.

-----
## Installation

```Smalltalk
[ Metacello new
    baseline: 'ReinforcementLearning';
    repository: 'github://bergel/ReinforcementLearning:main';
    load ] on: MCMergeOrLoadWarning do: [:warning | warning load ]
```
------
## Screenshots

Here are some screenshots of the visualization to illustrates the execution of the Q-Learning algorithm. The example describes the classical scenario where a knight need to exit a map while avoiding monsters. Here is the solution that shows the path from the starting point (large blue dot) toward the exit (yellow cell), while avoiding monsters (light red cells):

<img width="595" alt="image" src="https://user-images.githubusercontent.com/393742/131110454-6b1e3313-795c-4459-9a2d-446ba4f6d4d8.png">


