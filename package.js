Package.describe({
  name: 'miguelalarcos:afwrap-xautocomplete',
  summary: 'wrap over xautocomplete so it works ok with autoform',
  version: '0.3.1',
  git: 'https://github.com/miguelalarcos/afwrap-xautocomplete.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.2.1');
  api.use('coffeescript', 'client');
  api.use('jquery', 'client');
  api.use('templating', 'client');
  api.use('aldeed:autoform@5.0.2', 'client');
  api.use('miguelalarcos:xautocomplete@0.3.0', 'client');
  api.addFiles(['wrap.coffee'], 'client');
});


