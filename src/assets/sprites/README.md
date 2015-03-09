# Image Sprites Mixin

## Naming Convention

- 2x images must have a "-2x" suffix.

## Usage

### In Jade:

	+sprite(src="fileName-2x.png" alt="altText")

### From Stylus:

	.foo
	  @extend .sprite--fileName-2x

## Bonus

- No need to write __width__ or __height__ and even __path__ in both cases.

## Browser Support

- IE 9+ and others.
