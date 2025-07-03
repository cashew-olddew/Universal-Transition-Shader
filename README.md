# Universal Transition Shader

Most common transitions inside one Godot shader. 🎬

## Introduction

This shader provides a flexible and highly customizable system for creating animated transitions between visual elements in a Godot project. It supports a wide variety of transition styles, such as:

- **Directional Wipes**: (left, right, top, bottom, diagonal)
- **Clock Wipes**: (radial, with multi-sector support)
- **Iris/Shape Reveals**: (polygon-based transitions with any number of sides)
- **Dissolves**
- **Fades**
- **Slides**
- **Combinations & Variations**

To get started quickly, jump to the [quickstart](#quick-start) or [common transition recipes](#common-transition-recipes) sections.

For in depth documentation, check the [parameters reference](#parameters-reference) section.

## Quick Start

1. Attach the shader to any `CanvasItem` (like a `Sprite2D` or `TextureRect`).
- _Alternatively, you can clone this repository and open the included demo project for a ready-to-use example._
2. In the Godot Inspector, navigate to:
**Material → Shader → Animation**
3. Adjust the `progress` value to trigger a transition.
4. Explore other parameters to try different transition styles and effects.

## Common Transition Recipes

**Let's cook!** 🍜

_Hint: Each recipe contains only the most basic 'ingredients', without which the recipe wouldn't work. Feel free to add any additional parameters to get variations of these recipes._

**Simple Fade**
- `transition_type`: Basic
- `grid_size`: (0.0, 0.0)
- `gradient_width`: Any value > 0.0

**Directional Wipe**
- `transition_type`: Basic
- `grid_size`: (1.0, 0.0) or (0.0, 1.0) or (-1.0, 0.0) or (0.0, -1.0) 

**Corner Wipe**
- `transition_type`: Basic
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)

**Diagonal Wipe**
- `transition_type`: Basic
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)
- `rotation_angle`: 45.0

**Center Wipe**
- `transition_type`: Basic
- `from_center`: true

**Blinder Wipe**
- `transition_type`: Basic
- `grid_size`: (0.0, `abs(y) > 2.0`) or (`abs(x) > 2.0`, 0.0)

**Grid Reveal**
- `transition_type`: Basic
- `from_center`: true
- `grid_size`: (10.0, 10.0) - or any abs(x) > 0.0; abs(y) > 0.0;

**Staggered Grid Reveal**
- `transition_type`: Basic
- `from_center`: true
- `grid_size`: (10.0, 10.0) - or any abs(x) > 0.0; abs(y) > 0.0;
- `stagger`: (1.0, 0.0) or (0.0, 1.0)

**Cross-shaped Transition (All corners wipe)**
- `transition_type`: Basic
- `from_center`: true
- `stagger`: (1.0, 1.0)

**Iris Transition**
- `transition_type`: Shape
- `from_center`: true
- `edges`: 64
- `feather`: 0.5

**Spike Transition**
- `transition_type`: Shape
- `from_center`: true
- `grid_size` & `rotation_angle`: `(0.5, y) & 0.0` or `(x, -0.5) & 90.0`

**Corner-Clock Transition**
- `transition_type`: Clock
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)

**Center-Clock Transition**
- `transition_type`: Clock
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)

**Fan Transition**
- `transition_type`: Clock
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)
- `sectors`: 2 or more

## Parameters Reference

The shader parameters are organized into the following categories:
- **[Shader Parameters](#shader-parameters)**: Generic shader settings that apply to the overall behavior of the transition, such as the `Transition Type`
- **[Positioning](#positioning)**: Used for positioning and orientation of the transition, applying to all transition types
	- **[Stagger](#stagger)**: Handle offset of grid rows and columns, allowing for more varied grid patterns.
- **[Basic Transition Controls](#basic-transition-controls)**: Parameters specific to the "Basic" transition type.
- **[Mask Transition Controls](#mask-transition-controls)**: Parameters specific to the "Mask" transition type.
- **[Shape Transition Controls](#shape-transition-controls)**: Parameters specific to the "Shape" transition type.
- **[Clock Transition Controls](#clock-transition-controls)**: Parameters specific to the "Clock" transition type.
- **[Animation](#animation)**: Control the progression of the animation.

### Shader Parameters

---

`use_sprite_alpha` (`bool`, default: `true`)

When `false`, the `CanvasItem`'s original alpha is ignored.

When `true`, the final pixel's transparency will be the minimum of the sprite's original alpha and the transition's calculated alpha. This ensures that already-transparent parts of your sprite remain transparent throughout the transition.

---

`use_transition_texture` (`bool`, default: `false`)

When `false`, the shader blends from the original `COLOR` of the `CanvasItem` to a fully transparent `COLOR`, effectively revealing what's behind the `CanvasItem`.

When `true`, the shader blends from the original `COLOR` of the `CanvasItem` to the `COLOR`of the texture provided under the `transition_texture` parameter.

_Hint: If `transition_texture` is not set, the shader blends between `COLOR` and white._

---

`transition_texture` (`sampler2D`)

The texture that will be transitioned to/from when `use_transition_texture` is set to `true`.

_Hint: Has no effect if `use_transition_texture` is `false`._

---

`transition_type` (`int`, hint: `enum("Basic", "Mask", "Shape", "Clock")`, default: `0` (Basic))

Selects the fundamental algorithm or visual style for the transition effect.

- `0` (Basic): Implements simple, rectangular, gradient-based wipes and fades.
- `1` (Mask): Implements mask-based transitions.
- `2` (Shape): Generates a regular convex polygon as the transition boundary.
- `3` (Clock): Creates a radial, clock-like wipe effect.

_Hint: Adjustments to parameters within a specific "Transition Controls" group (e.g. "Basic Transition Controls") will only affect the transition if the corresponding `transition_type` is selected._

---

### Positioning

These parameters influence the spatial origin, direction, and tiling of the transition, and they apply universally across all `transition_types`.

---

`invert` (`bool`, default: `false`)

Reverses the logical direction of the transition's progression. For example, a transition that normally expands outwards would contract, or a wipe from left to right would become right to left.

---

`from_center` (`bool`, default: `false`)

When `false`, the origin is typically one of the edges or corners, depending on `grid_size`, `stagger` and `rotation_angle`.

When `true`, the transition's origin point is considered the center of the `CanvasItem`'s local coordinate system. 

---

`grid_size` (`vec2`, default: `(1.0, 1.0)`)

Divides the `CanvasItem`'s area into a grid of independently animating cells. The `x` component defines the number of horizontal divisions, and the `y` component defines the number of vertical divisions. A value of `(1.0, 1.0)` means no division, treating the entire `CanvasItem` as a single cell.

Using **negative values**, **zero values**, or **floating-point** numbers for the `grid_size` introduces interesting and powerful behaviors. 

For instance, `(-1.0, 0.0)` will create a right-to-left wipe. Values like `(0.0, 0.0)` can even produce a simple fade, given the transition has a blur.

Experiment to find more special `grid_size` values or check out the [common transition recipes](#common-transition-recipes) section for more examples.

---

`rotation_angle` (`float`, default: `0.0`)

Rotates the local coordinate system within each grid cell (or the entire `CanvasItem` if `grid_size` is `(1.0, 1.0)`). The angle is specified in degrees.

---

#### Stagger

These parameters introduce offsets and flipping to individual grid cells, creating more complex and dynamic grid-based patterns.

---

`stagger` (`vec2`, default `(0.0, 0.0)`)

Applies a fractional offset to the UV coordinates of alternating grid rows and columns before the transition calculation. This can create a "checkerboard" or "wave" effect when combined with a `grid_size` greater than `(1.0, 1.0)`.

_Hint 1: When `grid_size` is `(1.0, 1.0)` or smaller, this just offsets the transition location._

_Hint 2: Due to each element having limited space in its cell, applying a stagger on both axis can lead to interesting patterns._

---

`stagger_frequency` (`ivec2`, default: `(2, 2)`)

Determines how often the stagger offset is applied to grid cells.

- `x`: Controls the frequency for rows (every `x` rows are staggered).
- `y`: Controls the frequency for columns (every `y` columns are staggered).

For example, `(1, 0)` staggers every single row, while `(2, 0)` staggers every second row.

---

`flip_frequency` (`ivec2`, default: `(1, 1)`)

Controls the frequency at which the local UV coordinates within grid cells are flipped (mirrored).

- `x`: Flips horizontally every `x` rows.
- `y`: Flips vertically every `y` columns.

This introduces visual variation and can create interesting symmetrical or asymmetrical patterns within a grid.

---

### Basic Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `0` (Basic).

---

`gradient_width` (`float`)

Controls the softness or blurriness of the transition's edges.

---

### Mask Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `1` (Mask).

---

`mask_texture` (`sampler2D`)

---

`mask_size` (`vec2`)

---

### Shape Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `2` (Shape).

---

`edges` (`int`, hint: `range(3, 64)`, default: `6`)

Specifies the number of sides (edges) of the regular polygon shape that forms the transition boundary. A value of `3` creates a triangle, `4` a square (or diamond if rotated), `5` a pentagon, and so on. Higher values approximate a circle.

---

`feather` (`float`, hint: `range(0.0, 10.0)`, default: `0.1`)

Controls the softness or blurriness of the polygon's edges. A value of `0.0` results in a perfectly sharp polygon outline, while increasing the value expands the feathered transition zone, creating a softer blend.

---

### Clock Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `3` (Clock).

---

`sectors` (`int`, hint: `range(1, 128)`, default: `1`)

Determines how many radial segments (sectors) the clock-wipe effect is divided into.

---

`clock_feather` (`float`, hint: `range(0.0, 16.0)`, default `0.0`)

Controls the amount of feathering or blur applied to the edges of the individual clock sectors. A `0.0` value produces sharp, distinct sector edges, while higher values create a smoother transition

---

### Animation

These parameters are the backbone of this shader as they control the timing of the transition.

---

`progress` (`float`, default: `0.0`)

The primary control for advancing the transition. It is the overall stage of the animation.

Typically, `0.0` means the transition has not started, and `1.0` means the transition is complete. (or the other way around if `invert` is set to `true`)

_Hint: Sometimes this is not the case. For example, one might provide a mask that's too small and needs values greater than `1.0` to fully cover the `CanvasItem` area. In such cases, play around with the property to figure out when the animation starts and when it ends._

---

`progress_bias` (`vec2`, default: `(0.0, 0.0)`)

Applies an additional offset to the progress value for each individual grid cell. 

- The `x` component biases progress across columns.
- the `y` component biases progress across rows. 

This allows for creating "wave-like" or "staggered" animation effects where grid cells transition at slightly different times based on their position.

## License

This project and shader falls under the [CC0](LICENSE) license, meaning that you can do anything you want with the code here, even use it commercially. You do not have any obligation to credit me, but doing so would be highly appreciated.

## Support

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/H2H2XSCXW)

Donations are appreciated and help me continue creating free content. Please donate only what you can afford. 🥜