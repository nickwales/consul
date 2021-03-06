#!/usr/bin/env bats

load helpers

@test "s2 proxy is running correct version" {
  assert_envoy_version 19001
}

@test "s2 proxy admin is up on :19001" {
  retry_default curl -f -s localhost:19001/stats -o /dev/null
}

@test "s2 proxy listener should be up and have right cert" {
  assert_proxy_presents_cert_uri localhost:21000 s2 secondary
}

@test "s2 proxy should be healthy" {
  assert_service_has_healthy_instances s2 1 secondary
}