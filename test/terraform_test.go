

package test

import (
	"fmt"
	"testing"
	"time"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"strings"
)

func TestWebServer(t *testing.T) {
	terraformOptions := &terraform.Options {
	  // The path to where your Terraform code is located
	  TerraformDir: "../",
	}  // At the end of the test, run `terraform destroy`
	defer terraform.Destroy(t, terraformOptions)  // Run `terraform init` and `terraform apply`
	terraform.InitAndApply(t, terraformOptions)  // Run `terraform output` to get the value of an output variable
	loadBalancerUrl := terraform.Output(t, terraformOptions, "load_balancer_dns_name")  // Verify that we get back a 200 OK with the expected text. It
	// takes ~1 min for the Instance to boot, so retry a few times.
	retries := 30
	sleep := 5 * time.Second  
	url := fmt.Sprintf("https://%s", loadBalancerUrl)
	//http_helper.HttpGetWithRetry(t, url, nil, status, text, retries, sleep)
	http_helper.HttpGetWithRetryWithCustomValidation(
        t,
        url,
		nil,
        retries,
        sleep,
        func(statusCode int, body string) bool {
            isOk := statusCode == 200
            isNginx := strings.Contains(body, "Hello World!")
            return isOk && isNginx               
        },
    )
  }
