// Copyright (c) 2023 Avaloq and/or its affiliates.
// Licensed under the Apache 2.0 license shown at https://www.apache.org/licenses/LICENSE-2.0.

resource "example_thing" "iam" {
  for_each = fileset(path.module, "iam/*.json")

  # other configuration using each.value
}