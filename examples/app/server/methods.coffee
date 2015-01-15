Meteor.methods
  'items': (query) ->
    if query != ''
      authors.find({surname: {$regex: ".*^"+query+".*$", $options: 'i'}}).fetch()
    else
      []
  'save': (doc, set, _id) ->
    console.log doc, set, _id
    if _id
      books.update({_id: _id}, set)
    else
      books.insert(doc)

authors = @authors
authors.remove({})
authors.insert {_id:'0', name: 'Richard', surname:'Dawkins'}
authors.insert {_id: '1', name: 'Daniel', surname:'Dennet'}
authors.insert {_id: '2', name: 'Charles', surname:'Darwin'}

books = @books

Meteor.publish 'booksPub', -> books.find()
Meteor.publish 'authorsPub', -> authors.find()