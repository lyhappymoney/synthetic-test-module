terraform {
  required_providers {
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.0"
    }
  }
}

variable "datadog_api_key" {
  type    = string
  default = "7c48a2fad72e4f349afd514ec5c51bac"
}
variable "datadog_app_key" {
  type    = string
  default = "ed3b3cdb108612b4c39e7d5e84e1a4cea28d5601"
}
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

module "datadog_sythetics_test" {
  source = "../.."

  # name      = "test-tf-module"
   synthetics_type = "api-test"
  # subtype   = "multi"
  # locations = ["aws:eu-central-1"]
  # tags      = ["terraform:true"]

  # options_list = {
  #   tick_every = 60

  #   retry = {
  #     count    = 2
  #     interval = 300
  #   }

  #   monitor_options = {
  #     renotify_interval = 120
  #   }
  # }

  # api_steps = [
  #   {
  #     name = "Test first"

  #     assertions = [
  #       {
  #         type     = "statusCode"
  #         operator = "is"
  #         target   = "200"
  #       },
  #       {
  #         type     = "statusCode"
  #         operator = "is"
  #         target   = "400"
  #       },
  #       {
  #         type     = "body"
  #         operator = "validatesJSONPath"
  #         targetjsonpath = {
  #           jsonpath    = "$.status"
  #           operator    = "contains"
  #           targetvalue = "UP"
  #         }
  #       }
  #     ]
  #     request_definition = {
  #       method = "GET"
  #       url    = "https://example.org"
  #     }
  #   },
  #   {
  #     name = "Test second"

  #     assertions = [
  #       {
  #         type     = "statusCode"
  #         operator = "is"
  #         target   = "200"
  #       },
        
  #       {
  #         type     = "body"
  #         operator = "validatesJSONPath"
  #         targetjsonpath = {
  #           jsonpath    = "$.status"
  #           operator    = "contains"
  #           targetvalue = "UP"
  #         }
  #       }
  #     ]
  #     request_definition = {
  #       method = "POST"
  #       url    = "https://google.org"
  #     }
  #   },
  #   {
  #     name = "Third second"

  #     assertions = [
  #       {
  #         type     = "statusCode"
  #         operator = "is"
  #         target   = "200"
  #       }
  #     ]
  #     request_definition = {
  #       method = "POST"
  #       url    = "https://google.org"
  #     }
  #   }
  # ]

    type    = "api"
    subtype = "ssl"
    request_definition = {
    host = "example.org"
    port = 443
    timeout = 90
  }
    

    assertions = [
        {
            type     = "certificate"
            operator = "isInMoreThan"
            target   = 30
          }
          # {
          #   type     = "statusCode"
          #   operator = "is"
          #   target   = "400"
          # },

          # {
          #   type     = "body"
          #   operator = "validatesJSONPath"
          #   targetjsonpath = {
          #     jsonpath    = "$.status"
          #     operator    = "contains"
          #     targetvalue = "UP"
          # }
          # }
    ]

    
    locations = ["aws:us-east-1"]
    options_list = {
      tick_every = 900
      accept_self_signed = true

      retry = {
        count    = 0
        interval = 300
      }
      monitor_name     = " Test Health Check - DEV"
      monitor_priority = 2
      ci = {
        execution_rule = "blocking"
      }

      # monitor_options ={
      #   renotify_interval = 120
      # }
    }
    name = "Test on lmp.dev.aws-ue1.happymoney.com"
    # message = "{{#is_alert}}${local.service_name} is down.@lyadav@happymoney.com {{/is_alert}} ${local.alertEmoji}{{#is_recovery}}${local.service_name} has recovered.@lyadav@happymoney.com {{/is_recovery}} "
    tags = ["env:dev", "service:lmp-document-green"]

    status = "live"
}