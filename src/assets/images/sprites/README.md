# Image Sprites Mixin

## Naming Convention

- 2x images must have a "-2x" suffix.

## How to Use

### In Jade:

  +image(src="FileName-2x.png" alt="AltText")

### In Stylus:

  .foo
    @extend .image__FileName-2x

No need to write __width__, __height__ and even __path__ in both cases.

## Browser Support

- IE 9+ and others.
