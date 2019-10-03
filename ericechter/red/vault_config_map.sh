kubectl create configmap vault \
  --cluster="$(gke-cluster-name "vault")" \
  --from-literal="load_balancer_address=$(vault-lb-ip)" \
  --from-literal="gcs_bucket_name=$(google-project)-vault-storage" \
  --from-literal="kms_project=$(google-project)" \
  --from-literal="kms_region=$(google-region)" \
  --from-literal="kms_key_ring=vault" \
  --from-literal="kms_crypto_key=vault-init" \
  --from-literal="kms_key_id=projects/$(google-project)/locations/$(google-region)/keyRings/vault/cryptoKeys/vault-init"
