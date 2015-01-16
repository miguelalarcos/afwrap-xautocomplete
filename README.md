afwrap-xautocomplete
====================

This is a wrap over the [xautocomplete](https://github.com/miguelalarcos/xautocomplete.git) package to work with ```AutoForm```.

In the examples folder you have a working example and a battery of tests with ```Jasmine```.

Examples:

```html
{{#autoForm id="1" doc=this type="method" meteormethod='save' schema='bookSchema'}}
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='surname' call='authors' valuefunction='valueAuthors' renderfunction='renderAuthors'}}</div>
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='surnames' call='authors' xmultiple='true' valuefunction='valueAuthors' renderfunction='renderAuthors'}}</div>
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='authorId' call='authors' reference='authors' valuefunction='valueAuthors' renderfunction='renderAuthors'}}</div>
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='authorsId' call='authors' xmultiple='true' reference='authors' valuefunction='valueAuthors' renderfunction='renderAuthors'}}</div>
    <div><button class="ui button" type="submit">submit</button></div>
{{/autoForm}}
```