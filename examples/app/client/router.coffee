books = @books
bookId =  new ReactiveVar(null)

class MyController extends RouteController
  waitOn: -> [Meteor.subscribe('booksPub'), Meteor.subscribe('authorsPub')]
  data: -> #books.findOne(_id:'0')
    if bookId.get() is null
      {}
    else
      books.findOne(_id: bookId.get())

Router.map ->
  @route 'hola',
    path: '/'
    controller: MyController


Template.hola.helpers
  books: books.find()

Template.hola.events
  'click a': (e,t)->
    _id = $(e.target).attr('_id')
    bookId.set(_id)
  'click #clear': (e,t)->
    bookId.set(null)

@renderAuthors = (x) -> Blaze.toHTMLWithData(Template.authors, x)
@valueAuthors = (x) -> x.surname + ', '+ x.name
  #if x
  #  x.surname + ', '+ x.name
  #else
  #  null