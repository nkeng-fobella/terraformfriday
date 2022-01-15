
    "Conditions": {
      "CreateProdResources": {
        "Fn::Equals" : [{ "Ref": "EnvType" }, "prod"]
      },
      "CreateTestResources": {
        "Fn::Equals" : [{ "Ref": "EnvType" }, "test"]
      }

    },
    "Resources": {
      "myInstance": {
        "Condition":"CreateProdResources",
        "Type": "AWS::EC2::Instance",
        "Properties": {
            "SubnetId": { "Fn::ImportValue" : "my-privateSubnet1-id" },
            "SecurityGroupIds": [{ "Fn::ImportValue" : "my-internalSG-id" }],
            "ImageId": {"Fn::FindInMap": [
                "Regions",
                { "Ref" : "AWS::Region" },
                { "Ref": "EnvType" }
            ]},
            "InstanceType": "t3.micro",
            "Tags": [{ "Key": "Name", "Value":  { "Ref": "EnvType" } }]


    }
  },
      "myInstance2": {
      "Condition":"CreateTestResources",
      "Type": "AWS::EC2::Instance",
      "Properties": {
          "ImageId":{"Fn::FindInMap": [
              "Regions",
              { "Ref" : "AWS::Region" },
              { "Ref": "EnvType" }
