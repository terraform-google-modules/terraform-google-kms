/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  keyring_id   = var.existing_keyring ? data.google_kms_key_ring.key_ring[0].id : google_kms_key_ring.key_ring[0].id
  key_opts_map = { for opts in var.key_opts : opts.key => opts }

  key_opts_default = {
    rotation_period  = "86400s"
    algorithm        = "GOOGLE_SYMMETRIC_ENCRYPTION"
    protection_level = "SOFTWARE"
    labels           = {}
    prevent_destroy  = true
  }

  key_opts = { for key in var.keys : key =>
    merge(
      local.key_opts_default,
      lookup(local.key_opts_map, key, {}),
    )
  }

  keys           = { for k, v in local.key_opts : k => v if v.prevent_destroy }
  ephemeral_keys = { for k, v in local.key_opts : k => v if v.prevent_destroy == false }

  crypto_keys = merge(
    google_kms_crypto_key.key,
    google_kms_crypto_key.ephemeral_key
  )

  encrypters_list = flatten([
    for rule in var.acl : [
      for identity in lookup(rule, "encrypters", []) : {
        key      = rule.key
        key_id   = local.crypto_keys[rule.key].id
        identity = identity
        role     = "roles/cloudkms.cryptoKeyEncrypter"
        type     = "encrypter"
      }
    ]
  ])

  decrypters_list = flatten([
    for rule in var.acl : [
      for identity in lookup(rule, "decrypters", []) : {
        key      = rule.key
        key_id   = local.crypto_keys[rule.key].id
        identity = identity
        role     = "roles/cloudkms.cryptoKeyDecrypter"
        type     = "decrypter"
      }
    ]
  ])

  owners_list = flatten([
    for rule in var.acl : [
      for identity in lookup(rule, "owners", []) : {
        key      = rule.key
        key_id   = local.crypto_keys[rule.key].id
        identity = identity
        role     = "roles/owner"
        type     = "owner"
      }
    ]
  ])

  iam_rules = { for i in concat(local.encrypters_list, local.decrypters_list, local.owners_list) :
    "${i.type}/${i.identity}" => i
  }
}
