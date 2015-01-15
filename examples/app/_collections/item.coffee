@authors = new Meteor.Collection 'Authors',
  schema:
    authorId:
      type: String
      optional: true
    authorsId:
      type: [String]
      optional: true


@bookSchema = bookSchema = new SimpleSchema
  surname:
    type: String
    optional: true
  surnames:
    type: [String]
    optional: true
  authorId:
    type: String
    optional: true
  authorsId:
    type: [String]
    optional: true

@books = new Meteor.Collection 'Books',
  schema: bookSchema
