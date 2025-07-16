
<h1>
	<img src="https://github.com/user-attachments/assets/0a6cbb58-0594-414d-aa70-d1a90997e7a8" width="48" align="center"/>
	Universal Transition Shader
	<img src="https://github.com/user-attachments/assets/0a6cbb58-0594-414d-aa70-d1a90997e7a8" width="48" align="center"/>
</h1>

Most common transitions inside one Godot shader. 🎬

## Introduction

_Hint:_ You can watch a brief guide video of the shader on my [youtube channel](https://www.youtube.com/watch?v=PtBZs7OvR2Y), or see it on [Godot Shaders](https://godotshaders.com/shader/universal-transition-shader/?post_id=11966)

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
- `basic_feather`: Any value > 0.0

<img src="https://github.com/user-attachments/assets/765b83b8-2d29-4e20-8704-872bb41d90bb" width="100" />

**Directional Wipe**
- `transition_type`: Basic
- `grid_size`: (1.0, 0.0) or (0.0, 1.0) or (-1.0, 0.0) or (0.0, -1.0)

<img src="https://github.com/user-attachments/assets/ae0b2c5e-2be3-48fc-99b8-344aae1a30db" width="80" />
<img src="https://github.com/user-attachments/assets/3114a42b-805d-4e13-aedd-47e077bd45a9" width="80" />
<img src="https://github.com/user-attachments/assets/1c517e71-9930-40a4-acb9-73ed1bf4a7e4" width="80" />
<img src="https://github.com/user-attachments/assets/6597ab7a-e1fb-4c78-aa36-5e5aec883546" width="80" />

**Corner Wipe**
- `transition_type`: Basic
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)

<img src="https://github.com/user-attachments/assets/b4870810-99a1-48ae-916a-dc40585dd9e2" width="80" />
<img src="https://github.com/user-attachments/assets/88c8bb1d-0746-4017-9962-7b3f5cdb05b8" width="80" />
<img src="https://github.com/user-attachments/assets/741ae9ec-ffda-49f9-8729-87a14cb07d7e" width="80" />
<img src="https://github.com/user-attachments/assets/255603bb-79e6-494a-95b9-f9cc5f1b7af1" width="80" />

**Diagonal Wipe**
- `transition_type`: Basic
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)
- `rotation_angle`: 45.0

<img src="https://github.com/user-attachments/assets/33281653-ccc1-4b17-9292-165b6317b414" width="80" />
<img src="https://github.com/user-attachments/assets/37425d76-5a0d-4272-aa80-4674f1960663" width="80" />
<img src="https://github.com/user-attachments/assets/427df89b-9f5f-42de-95aa-57e0c0a62938" width="80" />
<img src="https://github.com/user-attachments/assets/59824309-91b8-4df4-a780-517b0bf79deb" width="80" />

**Center Wipe**
- `transition_type`: Basic
- `position`: (0.5, 0.5)

<img src="https://github.com/user-attachments/assets/79827e31-7be0-454d-bcf3-cfb5a43a3626" width="100" />

**Blinder Wipe**
- `transition_type`: Basic
- `grid_size`: (0.0, `abs(y) > 2.0`) or (`abs(x) > 2.0`, 0.0)

<img src="https://github.com/user-attachments/assets/6fd5d274-379e-40f1-8c74-d9221bc521f6" width="80" />
<img src="https://github.com/user-attachments/assets/f5e3434b-b2d6-40ba-bd1b-344a04d24dfe" width="80" />
<img src="https://github.com/user-attachments/assets/065f3022-d058-4007-a2d3-29c6b5b78dba" width="80" />
<img src="https://github.com/user-attachments/assets/8d530969-59c1-4a2d-b118-9d2dfa67a0a8" width="80" />

**Grid Reveal**
- `transition_type`: Basic
- `position`: (0.5, 0.5)
- `grid_size`: (10.0, 10.0) - or any abs(x) > 0.0; abs(y) > 0.0;

<img src="https://github.com/user-attachments/assets/a4b460e9-c43d-4d57-b656-631e5ea0f4e6" width="100" />

**Staggered Grid Reveal**
- `transition_type`: Basic
- `position`: (0.5, 0.5)
- `grid_size`: (10.0, 10.0) - or any abs(x) > 0.0; abs(y) > 0.0;
- `stagger`: (1.0, 0.0) or (0.0, 1.0)

<img src="https://github.com/user-attachments/assets/8da31227-416d-41f3-9119-ebbe4e04c84f" width="80" />
<img src="https://github.com/user-attachments/assets/3da53446-4fa8-4930-bc88-0cda908586a3" width="80" />

**Mixed Stagger Reveal**
- `transition_type`: Basic
- `position`: (0.5, 0.5)
- `grid_size`: (5.0, 5.0)
- `stagger`: (1.0, 1.0)

<img src="https://github.com/user-attachments/assets/25a972cf-da15-432c-80d7-8e53a8a8d222" width="100" />

**Cross-shaped Transition (All corners wipe)**
- `transition_type`: Basic
- `position`: (0.5, 0.5)
- `stagger`: (1.0, 1.0)

<img src="https://github.com/user-attachments/assets/24819aeb-16a8-40f2-bfd3-e3434fd9d7a7" width="100" />

**Diagonal Popping Squares**
- `transition_type`: Basic
- `position`: (0.5, 0.5)
- `grid_size`: (5.0, 5.0)
- `progress_bias`: (10.0, 10.0)

<img src="https://github.com/user-attachments/assets/c6d7a904-bd1f-454b-ba73-6c9c463b7f52" width="100" />

**Step Wipe**
- `transition_type`: Basic
- `position`: (0.5, 0.5)
- `grid_size`: (5.0, 0.0) or (0.0, 5.0)
- `progress_bias`: (5.0, 0.0) or (0.0, 5.0)

<img src="https://github.com/user-attachments/assets/1dcf66f8-970d-4d98-88b3-5df1f2c43a76" width="80" />
<img src="https://github.com/user-attachments/assets/21ffe263-1385-4de4-8099-2637cb0b3dda" width="80" />

**Mask Reveal**
- `transition_type`: Mask
- `position`: (0.5, 0.5)
- `mask_texture`: Any black & white texture

<img src="https://github.com/user-attachments/assets/645de630-ee98-428e-8b0d-221f6e57446e" width="100" />

**Alternating Mask Grid**
- `transition_type`: Mask
- `position`: (0.5, 0.5)
- `grid_size`: (5.0, 5.0)
- `mask_texture`: Any black & white texture
- `flip_frequency`: (1.0, 2.0)

<img src="https://github.com/user-attachments/assets/2d59c7c2-d16e-4c3b-bce4-6b556aaea587" width="100" />

**Iris Transition**
- `transition_type`: Shape
- `position`: (0.5, 0.5)
- `edges`: 64
- `shape_feather`: 0.1

<img src="https://github.com/user-attachments/assets/0a6cbb58-0594-414d-aa70-d1a90997e7a8" width="100" />

**Spike Transition**
- `transition_type`: Shape
- `position`: (0.5, 0.5)
- `edges`: 3
- `grid_size` & `rotation_angle`: `(0.5, y) & 0.0` or `(x, -0.5) & 90.0`

<img src="https://github.com/user-attachments/assets/fd6e2d66-f820-469d-bdde-5cb173183eec" width="80" />
<img src="https://github.com/user-attachments/assets/a6e8f21f-8fe1-49ca-b78f-9b11aef2aa6c" width="80" />

**Scratch Lines Reveal**
- `transition_type`: Shape
- `position`: (0.5, 0.5)
- `grid_size`: (50.0, 5.0)
- `edges`: 3
- `flip_frequency`: (2.0, 1.0)

<img src="https://github.com/user-attachments/assets/74211200-a4e2-42b1-89ee-89c395423ac2" width="100" />

**Overlapping Diamonds**
- `transition_type`: Shape
- `position`: (0.5, 0.5)
- `grid_size`: (0.5, 50.0) or (50.0, 0.5)
- `edges`: 3
- `shape_feather`: 0.0

<img src="https://github.com/user-attachments/assets/f7e1d688-7d8d-421c-925b-0ac317fe7e4d" width="100" />

**Corner-Clock Transition**
- `transition_type`: Clock
- `invert`: true
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)

<img src="https://github.com/user-attachments/assets/6c5c0c29-2e99-4672-b339-558108412872" width="80" />
<img src="https://github.com/user-attachments/assets/856b1121-10ba-4d67-ac61-50d6c7a36006" width="80" />
<img src="https://github.com/user-attachments/assets/60928ab7-b22e-4e3d-ab9f-92583b1178b8" width="80" />
<img src="https://github.com/user-attachments/assets/f60b90a5-4a09-42bb-b440-def953b0abef" width="80" />

**Center-Clock Transition**
- `transition_type`: Clock
- `invert`: true
- `position`: (0.5, 0.5)
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)

<img src="https://github.com/user-attachments/assets/bdc012f3-7519-4f3c-bb38-098058a9b737" width="80" />
<img src="https://github.com/user-attachments/assets/8a717281-f404-4a8e-8b57-61ce9cff12f8" width="80" />
<img src="https://github.com/user-attachments/assets/75e1b7cb-a863-4432-a8a8-26769ad00cc4" width="80" />
<img src="https://github.com/user-attachments/assets/03d96d53-f3c3-490d-a868-b18d149786e1" width="80" />

**Fan Transition**
- `transition_type`: Clock
- `invert`: true
- `grid_size`: (1.0, 1.0) or (-1.0, -1.0) or (-1.0, 1.0) or (1.0, -1.0)
- `sectors`: 2 or more

<img src="https://github.com/user-attachments/assets/471f858f-5186-4f72-ad3d-c546294be25f" width="80" />
<img src="https://github.com/user-attachments/assets/4b8ec7f4-1665-4fdd-ab89-14d4c47212c8" width="80" />
<img src="https://github.com/user-attachments/assets/beee2f69-e70b-4785-a883-5ea12b00d722" width="80" />
<img src="https://github.com/user-attachments/assets/328e20d7-4631-4ed2-a841-d3d70b4e68f9" width="80" />

**Seamless Striped Flower Transition**
- `transition_type`: Clock
- `invert`: true
- `grid_size`: (5.0, 5.0)
- `flip_frequency`: (2, 2)
- `sectors`: 16

<img src="https://github.com/user-attachments/assets/723764e1-f130-4a73-aafb-21f94b1d67fc" width="100" />

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

The texture that will be transitioned to when `use_transition_texture` is set to `true`.

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

`position` (`vec2`, default: `(0.0, 0,0)`)

Specifies the position in each grid cell (see `grid_size` parameter) from where the transition starts.
- `(0.0, 0.0)` - top left corner
- `(1.0, 0.0)` - top right corner
- `(0,0, 1.0)` - bottom left corner
- `(1.0, 1.0)` - bottom right corner
- `(0.5, 0.5)` - center

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

`basic_feather` (`float`)

Controls the softness or blurriness of the transition's edges.

---

### Mask Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `1` (Mask).

---

`mask_texture` (`sampler2D`)

The grayscale image used as a mask for the transition. The white part of the mask shows the current texture and the black part shows the texture (or alpha) transitioned to.

---

`use_mask_size` (`bool`)

When `false` the mask texture keeps the aspect ratio of the CanvasItem.
When `true` the mask texture keeps the aspect ratio of the `mask_size` parameter. For example, if `mask_size` equals `(50, 25)`, the mask aspect ratio will stick to `2:1`

_Hint: This is experimental and works best for grids containing a single element. Currently, for larger grids, this introduces horizontal/vertical artifacts because of `fwidth`'s nature._

---

`mask_size` (`vec2`)

If `use_mask_size` is `true`, the `mask_texture`'s aspect ratio will be determined by `mask_size.x`:`mask_size.y`.

---

### Shape Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `2` (Shape).

---

`edges` (`int`, hint: `range(3, 64)`, default: `6`)

Specifies the number of sides (edges) of the regular polygon shape that forms the transition boundary. A value of `3` creates a triangle, `4` a square (or diamond if rotated), `5` a pentagon, and so on. Higher values approximate a circle.

---

`shape_feather` (`float`, hint: `range(0.0, 10.0)`, default: `0.1`)

Controls the softness or blurriness of the polygon's edges. A value of `0.0` results in a perfectly sharp polygon outline, while increasing the value expands the feathered transition zone, creating a softer blend.

---

### Clock Transition Controls

These parameters are exclusively relevant when `transition_type` is set to `3` (Clock).

---

`sectors` (`int`, hint: `range(1, 128)`, default: `1`)

Determines how many radial segments (sectors) the clock-wipe effect is divided into.

---

`clock_feather` (`float`, hint: `range(0.0, 16.0)`, default `0.0`)

Controls the amount of feathering or blur applied to the edges of the individual clock sectors. A `0.0` value produces sharp, distinct sector edges, while higher values create a smoother transition.

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

## Contributing

If you find any bugs, improvement ideas, interesting recipes, feel free to [fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#about-forks) this repository and suggest a change. Since the shader is quite simple, exploring and contributing to it can be a valuable learning experience for beginners.

If you'd like to see an improvement, but don't know how to contribute, you can [create an Issue](https://github.com/cashew-olddew/Universal-Transition-Shader/issues/new).

## License

This project and shader falls under the [CC0](LICENSE) license, meaning that you can do anything you want with the code here, even use it commercially. You do not have any obligation to credit me, but doing so would be highly appreciated.

## Support

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/H2H2XSCXW)

Donations are appreciated and help me continue creating free content. Please donate only what you can afford. 🥜
