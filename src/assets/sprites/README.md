# Image Sprites Mixin

## Filename

- @2x images must have a __"-2x"__ suffix, not a __"@2x"__.

## Usage

Jade:

```
+sprite(src="fileName-2x.png" alt="")
```

Stylus:

```
.foo
  $sprite--fileName-2x()
```

- No need to write __width__ or __height__ and even __path__ in both cases.

## Browser Support

- IE 9+ and others.
