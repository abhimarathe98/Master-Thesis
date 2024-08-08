Overview of the Master Thesis: Development of Simulation for Communication-Aware Motion Planning of Multi-Robot Systems in Multi-Network Areas
Introduction
This thesis addresses the integration of autonomous robotic systems in logistics, focusing on their application in warehousing and airport operations. The primary goal is to develop a simulation for communication-aware motion planning in multi-robot systems operating across multi-network areas, aiming to enhance efficiency and reliability in such environments.
Current Scenario
In modern logistics, autonomous robots are transforming warehousing operations. These systems are increasingly used in airports for tasks such as baggage handling, security, and maintenance. Traditional methods like conveyor belts are being replaced by multi-robot systems to handle rising passenger volumes and improve efficiency.
Problem Definition
The thesis identifies key challenges in transitioning from classical motion planning to communication-aware motion planning. Issues include communication latency, dynamic network conditions, scalability, and collision avoidance. The focus is on developing robust communication protocols and adaptive algorithms to address these challenges in multi-warehouse robot systems.
Objectives
The thesis is structured around five mandatory tasks and two optional tasks:
Develop a multi-robot motion planning simulation environment in MATLAB/Python/C++.
Research existing frameworks for communication-aware motion planning in warehousing.
Explore simulation tools for multi-robot systems.
Investigate multi-robot path planning in multi-network zones.
Compare various path planning algorithms and select the most effective one.
(Optional) Investigate mmWave applications for communication-aware motion planning.
(Optional) Assess the feasibility of 5G/6G mobile network technology.
Proposed Approach
Environment Setup
Define the warehouse layout using a suitable data structure like a grid or graph. This representation helps in visualizing the navigation area for robots.
Robot Models
Develop models for robots, including their kinematics, dynamics, sensors, and actuators. This involves creating structures to represent individual robots and their properties.
Motion Planning Algorithm
Implement suitable algorithms such as A*, Dijkstra, MILP, and RRT for motion planning in warehouse environments. The thesis will evaluate these algorithms based on factors like collision avoidance and communication requirements.
Communication Model
Define a model for robots to exchange information over WiFi, focusing on minimal interference and congestion. This involves selecting appropriate channels and optimizing communication quality.
Simulation Execution and Optimization
Implement a simulation loop where robots interact with the environment, plan paths, and communicate. Optimize the simulation for efficiency and evaluate performance using metrics such as path length and collision avoidance.
Conclusion
This thesis aims to bridge the gap between classical and communication-aware motion planning for multi-robot systems. By integrating real-time communication capabilities, the research seeks to optimize operations in logistics environments, such as airports and warehouses, enhancing overall system performance
