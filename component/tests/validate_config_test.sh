#!/usr/bin/env bash
$CZ component generate-config ../ > "${CZ_TMP_DIR}/generated_config.yaml"
$CZ ops valid-config "${CZ_TMP_DIR}/generated_config.yaml" ../schema/main.json ../schema
