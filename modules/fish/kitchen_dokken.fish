function dokken --wraps='set -xU KITCHEN_LOCAL_YAML kitchen.dokken.yml' --description 'alias dokken set -xU KITCHEN_LOCAL_YAML kitchen.dokken.yml'
  set -xU KITCHEN_LOCAL_YAML kitchen.dokken.yml $argv
end
