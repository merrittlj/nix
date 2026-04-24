{ host, helpers, ... }:
(helpers.bundleFiles ./modules)
++ (helpers.bundleFiles ./modules/${host})
