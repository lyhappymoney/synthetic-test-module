output "multi-test" {
  value = try(datadog_synthetics_test.multistep[0], "")
}

output "api-test" {
  value = try(datadog_synthetics_test.api-test[0], "")
}
