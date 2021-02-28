locals {
  keyring_self_link = var.existing_keyring ? data.google_kms_key_ring.key_ring[0].self_link : google_kms_key_ring.key_ring[0].self_link
  key_opts_map      = { for opts in var.key_opts : opts.key => opts }

  # Key with opts w/ labels "deep-merged"
  key_opts = { for key in var.keys : key =>
    merge(
      var.key_opts_default,
      lookup(local.key_opts_map, key, {}),
      {
        labels = merge(
          var.key_opts_default.labels,
          try(local.key_opts_map[key].labels, {})
        )
      }
    )
  }

  keys           = { for k, v in local.key_opts : k => v if v.prevent_destroy }
  ephemeral_keys = { for k, v in local.key_opts : k => v if v.prevent_destroy == false }

  crypto_keys = merge(
    google_kms_crypto_key.key,
    google_kms_crypto_key.ephemeral_key
  )

  acl_map = { for acl in var.acl : acl.key => acl }

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
        role     = "roles/cloudkms.cryptoKeyEncrypter"
        type     = "owner"
      }
    ]
  ])

  iam_rules = { for i in concat(local.encrypters_list, local.decrypters_list, local.owners_list) :
    "${i.type}/${i.identity}" => i
  }
}
