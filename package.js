Package.describe({
  name: 'miguelalarcos:afwrap-xautocomplete',
  summary: 'wrap over xautocmplete so it works ok with autoform',
  version: '0.1.0',
  git: 'https://github.com/miguelalarcos/afwrap-xautocomplete.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.2.1');
  api.use('coffeescript', 'client');
  api.use('jquery', 'client');
  api.use('templating', 'client');
  api.use('aldeed:autoform@4.2.2', 'client');
  api.use('miguelalarcos:xautocomplete', 'client');
  api.addFiles(['wrap.coffee'], 'client');
});


