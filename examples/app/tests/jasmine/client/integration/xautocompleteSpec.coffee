query = @_testing.query
items = @_testing.items
data = @_testing.data

result = [{_id:'0', name: 'Richard', surname:'Dawkins'},
  {_id: '1', name: 'Daniel', surname:'Dennet'},
  {_id: '2', name: 'Charles', surname:'Darwin'}]

dataBook = {_id:'0', title:'The dangerous idea of Darwin', authorId: '1', surname:'Dennet, Daniel', authorsId:[], surnames: []}

describe "simple", ->
  el= null
  beforeEach ->
    el = Blaze.renderWithData(Template.testing, {data: dataBook},$('body')[0])
    Meteor.flush()
  afterEach ->
    Blaze.remove(el)

  it "type a letter and query get", ->
    $('[formid=1]>.xautocomplete-input').val('F')
    event = jQuery.Event('keyup', {keyCode:70})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(query.get()).toBe('F')

  it "query.set and expect Meteor call", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()

    expect(Meteor.call.calls.first().args[0]).toBe('authors')
    expect(Meteor.call.calls.first().args[1]).toBe('D')

  it "query.set and expect pop over", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    long = items.find().fetch().length
    expect(long).toBe(3)
    expect($('[formid=1]>.xpopover>table>tr>td').text()).toBe('Richard DawkinsDaniel DennetCharles Darwin')

  it "query.set, right key and expect data", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')

  it "query.set, down key, right key and expect data", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 40})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')

  it "query.set, several down key, one right key and expect data", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 40})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    $('[formid=1]>.xautocomplete-input').trigger(event)
    $('[formid=1]>.xautocomplete-input').trigger(event)
    $('[formid=1]>.xautocomplete-input').trigger(event)
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')

  it "esc means popover to close", ->
    #event = jQuery.Event('keyup')
    #$('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 40})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    event = jQuery.Event('keyup', {keyCode: 27})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(items.find().fetch().length).toBe(0)

  it "click .item and expect data and items.length 0", ->
    #event = jQuery.Event('keyup')
    #$('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('click')

    $('[formid=1] tr[index=0].xitem').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')
    expect(items.find().fetch().length).toBe(0)

  it "data update means data goes to .xautocomplete-input", ->
    data.update({path: '1:surname'}, {$set:{value:'miguel'}})
    Meteor.flush()
    expect($('[formid=1]>.xautocomplete-input').val()).toBe('miguel')

  it "test set and get", ->
    $('[formid=1]').val('miguel')
    expect(data.findOne(path:'1:surname').value).toBe('miguel')
    v = $('[formid=1]').val()
    expect(v).toBe('miguel')

describe "simple reference", ->
  el= null

  beforeEach ->
    el = Blaze.renderWithData(Template.testing_reference, {data: dataBook},$('body')[0])
    Meteor.flush()

  afterEach ->
    Blaze.remove(el)

  it "test set and get", ->
    $('[formid=1]').val('0')
    expect(data.findOne(path:'1:authorId').value).toBe('Dawkins, Richard')
    v = $('[formid=1]').val()
    expect(v).toBe('0')

  it "query.set, expect data and get", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:authorId'}).value).toBe('Dawkins, Richard')
    v = $('[formid=1]').val()
    expect(v).toBe('0')


describe "multiple", ->
  el= null

  beforeEach ->
    el = Blaze.renderWithData(Template.testing_multiple, {data: dataBook},$('body')[0])
    Meteor.flush()

  afterEach ->
    Blaze.remove(el)

  it "set and get", ->
    $('[formid=1]').val(['XYZ', 'ABC'])
    array = data.find(path:'1:surnames').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual(['XYZ', 'ABC'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['XYZ', 'ABC'])

  it "set and expect labels", ->
    $('[formid=1]').val(['XYZ', 'ABC'])
    expect($('[formid=1]>span.label').length).toBe(2)
    span = $('[formid=1]>span.label')[0]
    expect($(span).text()).toEqual('XYZ ')
    span = $('[formid=1]>span.label')[1]
    expect($(span).text()).toEqual('ABC ')

  it "set, expect data and get", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)

    array = data.find(path:'1:surnames').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual(['Dawkins, Richard'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['Dawkins, Richard'])


describe "multiple reference", ->
  el= null

  beforeEach ->
    el = Blaze.renderWithData(Template.testing_multiple_reference, {data: dataBook},$('body')[0])
    Meteor.flush()

  afterEach ->
    Blaze.remove(el)

  it "set and get", ->
    $('[formid=1]').val(['0', '1'])
    array = data.find(path:'1:authorsId').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual([ 'Dawkins, Richard', 'Dennet, Daniel'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['0', '1'])

  it "set, expect labels", ->
    $('[formid=1]').val(['0', '1'])
    expect($('[formid=1]>span.label').length).toBe(2)
    span = $('[formid=1]>span.label')[0]
    expect($(span).text()).toEqual('Dawkins, Richard ')
    span = $('[formid=1]>span.label')[1]
    expect($(span).text()).toEqual('Dennet, Daniel ')

  it "query.set, right key, expect data and get", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)

    array = data.find(path:'1:authorsId').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual(['Dawkins, Richard'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['0'])

# WITH SETTINGS
renderAuthors = (x, query) ->
  Blaze.toHTMLWithData(Template.authors, x)
valueAuthor = (x) -> x.surname + ', ' + x.name
@settings1 = {valueFunction: valueAuthor, renderFunction: renderAuthors, call: 'authors'}

describe "Settings simple", ->
  el= null
  beforeEach ->
    #window.settings1 = {valueFunction: valueAuthor, renderFunction: renderAuthors, call: 'authors'}
    el = Blaze.renderWithData(Template.testing_settings, {data: dataBook},$('body')[0])
    Meteor.flush()
  afterEach ->
    Blaze.remove(el)

  it "type a letter and query get", ->
    $('[formid=1]>.xautocomplete-input').val('F')
    event = jQuery.Event('keyup', {keyCode:70})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(query.get()).toBe('F')

  it "query.set and expect Meteor call", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()

    expect(Meteor.call.calls.first().args[0]).toBe('authors')
    expect(Meteor.call.calls.first().args[1]).toBe('D')

  it "query.set and expect pop over", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    long = items.find().fetch().length
    expect(long).toBe(3)
    expect($('[formid=1]>.xpopover>table>tr>td').text()).toBe('Richard DawkinsDaniel DennetCharles Darwin')

  it "query.set, right key and expect data", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')

  it "query.set, down key, right key and expect data", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 40})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')

  it "query.set, several down key, one right key and expect data", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 40})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    $('[formid=1]>.xautocomplete-input').trigger(event)
    $('[formid=1]>.xautocomplete-input').trigger(event)
    $('[formid=1]>.xautocomplete-input').trigger(event)
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')

  it "esc means popover to close", ->
    #event = jQuery.Event('keyup')
    #$('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 40})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    event = jQuery.Event('keyup', {keyCode: 27})
    $('[formid=1]>.xautocomplete-input').trigger(event)
    expect(items.find().fetch().length).toBe(0)

  it "click .item and expect data and items.length 0", ->
    #event = jQuery.Event('keyup')
    #$('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('click')

    $('[formid=1] tr[index=0].xitem').trigger(event)
    expect(data.findOne({path: '1:surname'}).value).toBe('Dawkins, Richard')
    expect(items.find().fetch().length).toBe(0)

  it "data update means data goes to .xautocomplete-input", ->
    data.update({path: '1:surname'}, {$set:{value:'miguel'}})
    Meteor.flush()
    expect($('[formid=1]>.xautocomplete-input').val()).toBe('miguel')

  it "test set and get", ->
    $('[formid=1]').val('miguel')
    expect(data.findOne(path:'1:surname').value).toBe('miguel')
    v = $('[formid=1]').val()
    expect(v).toBe('miguel')


@settings2 = {reference: 'authors', valueFunction: valueAuthor, renderFunction: renderAuthors, call: 'authors'}
describe "Settings simple reference", ->
  el= null
  beforeEach ->
    el = Blaze.renderWithData(Template.testing_reference_settings, {data: dataBook},$('body')[0])
    Meteor.flush()

  afterEach ->
    Blaze.remove(el)

  it "test set and get", ->
    $('[formid=1]').val('0')
    expect(data.findOne(path:'1:authorId').value).toBe('Dawkins, Richard')
    v = $('[formid=1]').val()
    expect(v).toBe('0')

  it "query.set, expect data and get", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)

    expect(data.findOne({path: '1:authorId'}).value).toBe('Dawkins, Richard')
    #v = $('[formid=1]').val()
    #expect(v).toBe('0')


@settings3 = {xmultiple: 'true', valueFunction: valueAuthor, renderFunction: renderAuthors, call: 'authors'}
describe "multiple settings", ->
  el= null

  beforeEach ->
    el = Blaze.renderWithData(Template.testing_multiple_settings, {data: dataBook},$('body')[0])
    Meteor.flush()

  afterEach ->
    Blaze.remove(el)

  it "set and get", ->
    $('[formid=1]').val(['XYZ', 'ABC'])
    array = data.find(path:'1:surnames').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual(['XYZ', 'ABC'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['XYZ', 'ABC'])

  it "set and expect labels", ->
    $('[formid=1]').val(['XYZ', 'ABC'])
    expect($('[formid=1]>span.label').length).toBe(2)
    span = $('[formid=1]>span.label')[0]
    expect($(span).text()).toEqual('XYZ ')
    span = $('[formid=1]>span.label')[1]
    expect($(span).text()).toEqual('ABC ')

  it "set, expect data and get", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)

    array = data.find(path:'1:surnames').fetch()

    surnames = (x.value for x in array)
    expect(surnames).toEqual(['Dawkins, Richard'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['Dawkins, Richard'])


@settings4 = {xmultiple: 'true', reference: 'authors', valueFunction: valueAuthor, renderFunction: renderAuthors, call: 'authors'}
describe " Settings multiple reference", ->
  el= null

  beforeEach ->
    el = Blaze.renderWithData(Template.testing_multiple_reference_settings, {data: dataBook},$('body')[0])
    Meteor.flush()

  afterEach ->
    Blaze.remove(el)

  it "set and get", ->
    $('[formid=1]').val(['0', '1'])
    array = data.find(path:'1:authorsId').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual([ 'Dawkins, Richard', 'Dennet, Daniel'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['0', '1'])

  it "set, expect labels", ->
    $('[formid=1]').val(['0', '1'])
    expect($('[formid=1]>span.label').length).toBe(2)
    span = $('[formid=1]>span.label')[0]
    expect($(span).text()).toEqual('Dawkins, Richard ')
    span = $('[formid=1]>span.label')[1]
    expect($(span).text()).toEqual('Dennet, Daniel ')

  it "query.set, right key, expect data and get", ->
    event = jQuery.Event('keyup')
    $('[formid=1]>.xautocomplete-input').trigger(event)
    meteor_call = (call, query_, f) -> f(null, result)
    spyOn(Meteor, 'call').and.callFake meteor_call

    query.set('D')
    Meteor.flush()
    event = jQuery.Event('keyup', {keyCode: 39})
    $('[formid=1]>.xautocomplete-input').trigger(event)

    array = data.find(path:'1:authorsId').fetch()
    surnames = (x.value for x in array)
    expect(surnames).toEqual(['Dawkins, Richard'])
    v = $('[formid=1]').val()
    expect(v).toEqual(['0'])