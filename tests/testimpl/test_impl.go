package testimpl

import (
	"context"
	"os"
	"strings"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/applicationinsights/armapplicationinsights"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	subscriptionID := os.Getenv("AZURE_SUBSCRIPTION_ID")
	if len(subscriptionID) == 0 {
		t.Fatal("AZURE_SUBSCRIPTION_ID is not set in the environment variables ")
	}
	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}

	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}

	clientFactory, err := armapplicationinsights.NewClientFactory(subscriptionID, credential, &options)
	if err != nil {
		t.Fatalf("Unable to get clientFactory: %e\n", err)

	}

	componentsClient := clientFactory.NewComponentsClient()

	expectedRgName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
	expectedAppInsightsName := terraform.Output(t, ctx.TerratestTerraformOptions(), "app_insights_name")
	expectedAppInsightsId := terraform.Output(t, ctx.TerratestTerraformOptions(), "app_insights_id")

	res, err := componentsClient.Get(context.Background(), expectedRgName, expectedAppInsightsName, nil)
	if err != nil {
		t.Fatalf("Error occurred while getting resource: %e\n", err)
	}

	t.Run("AppInsightsExists", func(t *testing.T) {
		assert.Equal(t, strings.ToLower(expectedAppInsightsId), strings.ToLower(*res.ID), "Ids must match")
	})
}
