afwrap-xautocomplete
====================

This is a wrap over the [xautocomplete](https://github.com/miguelalarcos/xautocomplete.git) package to work with ```AutoForm```.

Explanation
-----------

In the examples folder you have a working example and a battery of tests with ```Jasmine```.

Examples:

```html
{{#autoForm id="1" doc=this type="method" meteormethod='save' schema='bookSchema'}}
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='surname' call='authors' fieldref='surname' renderfunction='renderAuthors'}}</div>
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='surnames' call='authors' xmultiple=true fieldref='surname' renderfunction='renderAuthors'}}</div>
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='authorId' call='authors' reference='authors' fieldref='surname' renderfunction='renderAuthors'}}</div>
    <div>{{> afFieldInput  type='xautocomplete' formid="1" name='authorsId' call='authors' xmultiple=true reference='authors' fieldref='surname' renderfunction='renderAuthors'}}</div>
    <div><button class="ui button" type="submit">submit</button></div>
{{/autoForm}}
```