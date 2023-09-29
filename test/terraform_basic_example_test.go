package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	//"github.com/stretchr/testify/assert"
	"os"
	"reflect"
	"testing"
)

const colorRed = "\033[0;31m"
const colorNone = "\033[0m"

func checkEqual(t *testing.T, expected, actual interface{}, successMessage string) {
	if reflect.DeepEqual(expected, actual) {
		//fmt.Println(successMessage)
		fmt.Fprintf(os.Stdout, "Red: %s %s %s\n", colorRed, successMessage, colorNone)
	} else {
		t.Errorf("FAIL: expected %v, but got %v", expected, actual)
	}
}

// An example of how to test the simple Terraform module in examples/terraform-basic-example using Terratest.
func TestTerraformBasicExample(t *testing.T) {
	t.Parallel()

	expectedText := "test"
	expectedList := []string{expectedText}
	expectedMap := map[string]string{"expected": expectedText}
	expectedRgName := "rg-tf-test"
	//expectedVnetLocation := "northeurope"

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// website::tag::1::Set the path to the Terraform code that will be tested.
		// The path to where our Terraform code is located
		TerraformDir: "../examples/terraform-basic-example",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"example": expectedText,

			// We also can see how lists and maps translate between terratest and terraform.
			"example_list":    expectedList,
			"example_map":     expectedMap,
			"example_rg_name": expectedRgName,
		},

		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"varfile.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: false, //true,
	})

	// website::tag::2::Run "terraform init" and "terraform apply".
	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the values of output variables
	actualTextExample := terraform.Output(t, terraformOptions, "example")
	actualTextExample2 := terraform.Output(t, terraformOptions, "example2")
	actualExampleList := terraform.OutputList(t, terraformOptions, "example_list")
	actualExampleMap := terraform.OutputMap(t, terraformOptions, "example_map")
	actualRgName := terraform.Output(t, terraformOptions, "example_rg_name")
	// actualVnetLocatioin := terraform.Output(t, terraformOptions, "vnet_location")

	// website::tag::3::Clean up resources with "terraform destroy". Using "defer" runs the command at the end of the test, whether the test succeeds or fails.
	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// website::tag::4::Check the output against expected values.
	// Verify we're getting back the outputs we expect
	checkEqual(t, expectedText, actualTextExample, "expectedText 1 OK")
	checkEqual(t, expectedText, actualTextExample2, "expectedText 2 OK")
	checkEqual(t, expectedList, actualExampleList, "expectedList 2 OK")
	checkEqual(t, expectedMap, actualExampleMap, "expectedMap OK")
	checkEqual(t, expectedRgName, actualRgName, "expectedRgName OK")

	// assert.Equal(t, expectedText, actualTextExample)
	// fmt.Println("expectedText 1 OK")
	// assert.Equal(t, expectedText, actualTextExample2)
	// fmt.Println("expectedText 2 OK")
	// assert.Equal(t, expectedList, actualExampleList)
	// fmt.Println("expectedList OK")
	// assert.Equal(t, expectedMap, actualExampleMap)
	// fmt.Println("expectedMap OK")
	// assert.Equal(t, expectedRgName, actualRgName)
	// fmt.Println("expectedRg Name OK")
	// assert.Equal(t, expectedVnetLocation, actualVnetLocatioin)
	// fmt.Println("expectedVnet Location OK")

}
