# HTML6

> New Front-end Bootstrap

```
$ git clone https://github.com/BYODKM/HTML6.git
$ cd HTML6
$ npm install
$ grunt
```

## Usage

```
include /html6/elements/main

doctype
+html(lang="ja")
  +head
    +title Title
    +meta(description="")
  +body#top
    .page#page--index
      section.page__body
        h1 Heading
        h2 Heading
        h3 Heading
```

## Elements

- [+accordion()](dev/html6/elements/mixins/accordion.jade)
- [+body()](dev/html6/elements/mixins/body.jade)
- [+button()](dev/html6/elements/mixins/button.jade)
- [+checkbox()](dev/html6/elements/mixins/checkbox.jade)
- [+code()](dev/html6/elements/mixins/code.jade)
- [+details()](dev/html6/elements/mixins/details.jade)
- [+head()](dev/html6/elements/mixins/head.jade)
- [+hx()](dev/html6/elements/mixins/hx.jade)
- [+icon()](dev/html6/elements/mixins/icon.jade)
- [+label()](dev/html6/elements/mixins/label.jade)
- [+margin()](dev/html6/elements/mixins/margin.jade)
- [+meta()](dev/html6/elements/mixins/meta.jade)
- [+radio()](dev/html6/elements/mixins/radio.jade)
- [+rating()](dev/html6/elements/mixins/rating.jade)
- [+row()](dev/html6/elements/mixins/row.jade)
- [+section()](dev/html6/elements/mixins/section.jade)
- [+select()](dev/html6/elements/mixins/select.jade)
- [+spacer()](dev/html6/elements/mixins/spacer.jade)
- [+sprite()](dev/html6/elements/mixins/sprite.jade)
- [+switch()](dev/html6/elements/mixins/switch.jade)
- [+title()](dev/html6/elements/mixins/title.jade)
- [+weak()](dev/html6/elements/mixins/weak.jade)

## Good dependencies

- [fastclick.js](https://github.com/ftlabs/fastclick)
- [classList.js](https://github.com/eligrey/classList.js)
- [normalize.css](https://github.com/necolas/normalize.css)
- [globalize.css](https://github.com/BYODKM/globalize.css)
- [nondestructive-reset.css](https://github.com/BYODKM/nondestructive-reset.css)
- [kouto-swiss](https://github.com/krkn/kouto-swiss)
- [legacy-gradient.styl](https://github.com/BYODKM/legacy-gradient.styl)

## Supported browsers

- IE 9+
- Others

## License

MIT
