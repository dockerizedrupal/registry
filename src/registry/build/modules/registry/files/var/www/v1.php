<?php

define('REGISTRY_V1_REPOSITORIES', '/registry/data/v1/repositories/library');

function registry_v1_repositories_get() {
  $items = scandir(REGISTRY_V1_REPOSITORIES);

  $items = array_diff($items, array(
    '.',
    '..',
  ));

  $repositories = array();

  foreach ($items as $repository) {
    $tags = registry_v1_repository_tags_get($repository);

    if ($tags) {
      ksort($tags);

      $repositories[$repository] = $tags;
    }
  }

  return $repositories;
}

function registry_v1_repository_tags_get($repository) {
  $items = scandir(REGISTRY_V1_REPOSITORIES . '/' . $repository);

  $items = array_diff($items, array(
    '.',
    '..',
  ));

  $tags = array();

  foreach ($items as $tag) {
    $matches = array();

    if (preg_match('/^tag_(.*)/', $tag, $matches)) {
      $tags[] = $matches[1];
    }
  }

  return array_combine($tags, $tags);
}

function registry_v1_tag_last_updated_get($repository, $tag) {
  $file_path = REGISTRY_V1_REPOSITORIES . '/' . $repository . '/tag' . $tag . '_json';

  if (file_exists($file_path)) {
    $file_contents = file_get_contents($file_path);

    $info = json_decode($file_contents, TRUE);

    return $info['last_update'];
  }
}
