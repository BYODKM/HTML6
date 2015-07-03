# Image Sprites Mixin

> Available for both HTML and CSS.

## Usage

```
// *.jade

+sprite(src="that.png" alt="")
```

```
// *.styl

div
  sprite("that.png")
```

No need to write _width_ or _height_ or even _file path_ in both cases.

## Supported browsers

- IE 9+
- Others

## Important Note

- File name will be used by class name. Must be different from each other.
- "@" sign is not allowed to use in class name. Use "-" or "_" instead.
