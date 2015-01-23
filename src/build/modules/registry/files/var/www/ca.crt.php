<?php

header('Content-Type: text/plain');

print file_get_contents('/registry/ssl/certs/registryCA.crt');
