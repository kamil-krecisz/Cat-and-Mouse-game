# 🧀 Cheese Defense

**Cheese Defense** is a top-down 2D game built in the Godot Engine. You play as a cat defending a warehouse full of cheese from invading mice. Catch them before they eat it all!

## 🎮 Game Description

You control a cat moving around a cheese warehouse. Mice spawn and roam freely, sometimes eating cheese they find. Your job is to catch them all by placing traps and purchasing upgrades to improve your speed and stamina.

## ⚙️ Core Mechanics

- Top-down cat movement (WASD + Shift for sprint)
- Enemy AI: Mice flee when the cat gets close and seek cheese around the warehouse
- Traps that capture mice
- Upgrade system (stamina, speed, etc.)
- Points and money system based on caught mice, used to buy upgrades and traps

## 🧠 Enemy AI

- Mice move randomly when idle
- When within detection radius, they flee from the cat (player)
- Direction changes periodically via timer
- Cheese detection and pathfinding (to be implemented)

## 🧰 Technologies Used

- **Engine:** Godot 4.4.1
- **Language:** GDScript
- **Graphics:** 2D pixel art
- **Version control:** Git + GitHub

## ✍️ Author

**Kamil Kręcisz**, 2025  
This game is an educational project and part of my portfolio for university admission (e.g. MIT) or IT job applications.

## 🚧 Planned Features

- Cheese-eating animation and mechanics for mice  
- Stamina system for both cat and mice - DONE  
- Pause menu and game over screen  
- Sound effects and background music  
