https://www.drupaleasy.com/blogs/ultimike/2020/07/entityquery-examples-everybody

https://www.drupal.org/node/1827278

https://drupal.stackexchange.com/questions/228548/how-to-load-a-node-by-a-field-value

https://www.drupal.org/forum/support/module-development-and-code-questions/2013-01-22/find-node-programmatically-by-field

Show me the SQL
    $query = \Drupal::entityQuery('node')
      ->condition('type', 'event')
      ->condition('field_location.entity:node.field_tag.entity:taxonomy_term', 'sailboat')
      ->__toString();

Entity queries by default consider the node grants system, you actually have to opt out of that to get everything when using node grants.      
    https://drupal.stackexchange.com/questions/230083/entity-query-not-returning-all-results
      