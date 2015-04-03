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
  sprite "that.png"
```

No need to write __width__ or __height__ and even __path__ in both cases.

## Browser Support

- IE 9+ and others.

## Limitations

- File name will be used by class name. Must not be the same name.
- @2x images must not have a "@2x" suffix. Use "-2x" or "_2x" instead.
