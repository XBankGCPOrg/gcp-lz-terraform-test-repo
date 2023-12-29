package test

import (
	"fmt"
	"log"
	"strings"
	"testing"
	"time"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestNamingScheme(t *testing.T) {

	const def_location = "europe-west2"
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../example",
	})
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// fetching outputs
	folderIds := terraform.OutputMap(t, terraformOptions, "folder_ids")
	projectIds := terraform.OutputMap(t, terraformOptions, "project_ids")
	lienName := terraform.OutputMap(t, terraformOptions, "lien_name")
	artifactRegistryString := terraform.Output(t, terraformOptions, "artifact_registry_name")
	pubSubNameList := terraform.OutputList(t, terraformOptions, "pub_sub_name")
	fmt.Println(folderIds)
	fmt.Println(projectIds)
	fmt.Println(artifactRegistryString)
	fmt.Println(pubSubNameList)

	// for key, value := range projectIds {
	// 	if strings.HasPrefix(key, "prj-c-sec") || strings.HasPrefix(key, "prj-c-log") {
	// 		gcloud.Run(t, fmt.Sprintf(" kms keys versions disable 1 --key %s --keyring %s --project %s --location %s ", value, value, value, def_location))
	// 	}
	// }

	// folder id validation
	for key := range folderIds {
		// := fmt.Sprintf("%d", key)
		if !strings.HasPrefix(key, "fldr") {
			log.Printf("Key doesn't start with %s", key)
		}
		log.Printf("Key %s", key)
		assert.True(t, strings.HasPrefix(key, "fldr"), fmt.Sprintf("Key doesn't start with 'fldr': %s", key))
	}

	// project id validation
	for key := range projectIds {
		//folder_key := fmt.Sprintf("%d", key)
		if !strings.HasPrefix(key, "prj") {
			log.Printf("Key doesn't start with %s", key)
		}
		log.Printf("Key %s", key)
		assert.True(t, strings.HasPrefix(key, "prj"), fmt.Sprintf("Key doesn't start with 'prj': %s", key))
	}

	// liens validation
	lienApplied := len(lienName) > 0

	if lienApplied {
		fmt.Sprintf("Lien is applied: %s", lienName)
	} else {
		fmt.Sprintf("No lien is applied")
	}

	assert.True(t, lienApplied, "Lien is not applied")

	assert.True(t, strings.HasPrefix(artifactRegistryString, "ar-"), fmt.Sprintf("Key doesn't start with 'ar': %s", artifactRegistryString))
	t.Logf("Artifact Registry Name: %s", artifactRegistryString)

	for _, pubSubName := range pubSubNameList {
		assert.True(t, strings.HasPrefix(pubSubName, "ps-"), fmt.Sprintf("Key doesn't start with 'ps': %s", pubSubName))
		log.Printf("pubSubName %s", pubSubName)
	}

	time.Sleep(30 * time.Second)

	for key, value := range projectIds {
		if strings.HasPrefix(key, "prj-c-sec") || strings.HasPrefix(key, "prj-c-log") {
			gcloud.Run(t, fmt.Sprintf(" kms keys versions disable 1 --key %s --keyring %s --project %s --location %s ", value, value, value, def_location))
		}
	}

}
