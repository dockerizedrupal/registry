<?php

define('REGISTRY_V2_REPOSITORIES', '/registry/data/v2/docker/registry/v2/repositories');

function registry_v2_repositories_get() {
  $items = scandir(REGISTRY_V2_REPOSITORIES);

  $items = array_diff($items, array(
    '.',
    '..',
  ));

  $repositories = array();

  foreach ($items as $repository) {
    $tags = registry_v2_repository_tags_get($repository);

    if ($tags) {
      ksort($tags);

      $repositories[$repository] = $tags;
    }
  }

  return $repositories;
}

function registry_v2_repository_tags_get($repository) {
  $items = scandir(REGISTRY_V2_REPOSITORIES . '/' . $repository . '/_manifests/tags');

  $tags = array_diff($items, array(
    '.',
    '..',
  ));

  return array_combine($tags, $tags);
}

function registry_v2_tag_last_updated_get($repository, $tag) {
  return filemtime(REGISTRY_V2_REPOSITORIES . '/' . $repository . '/_manifests/tags/' . $tag . '/current/link');
}
